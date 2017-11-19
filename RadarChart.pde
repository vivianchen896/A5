public class RadarChart extends Chart {

    int num_circle = 4;
    color data_c = color(100,149,237);

  
  RadarChart (Data data, int chartX, int chartY, int chartWidth, int chartHeight) {
   super(data, chartX, chartY, chartWidth, chartHeight);
    this.name = "Radar";    
  }
    
  float calculateXLabelWidth() {
    return 80.0; 
  }
  
  float calculateYLabelWidth() {
    return 80.0;
  }
  
  
  @Override
  public void draw() {
     
      stroke(0);
      rect(this.viewX, this.viewY, this.viewWidth, this.viewHeight);
       
      noFill();
      float diameter = min(this.viewWidth, this.viewHeight);
      
      float buffer = diameter/num_circle;
      
      float cent_x = this.viewX + (this.viewWidth/2);
      float cent_y = this.viewY + (this.viewHeight/2);
       
      //float maxim = this.data.yMax();
      float val_inc = 10.0 /num_circle;
      
      
      float val = 0;
      
      float pix_to_value = diameter/2/10;

      
      //four concentric circles wiht a distance of buffer in between
      //beginShape();
      //for(int i = 0; i <= num_circle; i++){
      //  stroke(0);
      //  ellipse(cent_x, cent_y, diameter, diameter);
        
      //  //draw the increments on radar chart
      //  fill(0);
      //  //textSize(8);
      //  //String val_to_print = nf(val, 1, 1);
      //  //text(val_to_print, cent_x, cent_y - val*pix_to_value+5);
      //  noFill();
        
      //  val += val_inc;
        
      //  diameter -= buffer;
      //}
      //endShape();
      
      ellipse(cent_x, cent_y, diameter, diameter);
      
      float degree_inc = (2 * PI)/data.size(); 
      //the end point on circle circumference
      float x_circ;
      float y_circ;
      float angle = -PI/2;
      //arrays to store all data coordinates on radard graph
      ArrayList<Float>data_x_pts = new ArrayList<Float>();
      ArrayList<Float>data_y_pts = new ArrayList<Float>();
      
      
      //draw the expanding lines from the center
      float outer_dia = min(this.viewWidth, this.viewHeight);
      for(int i = 0; i < data.size(); i++){
         x_circ = cent_x + outer_dia/2 * cos(angle);
         y_circ = cent_y + outer_dia/2 * sin(angle);
         stroke(0);   
         line( cent_x, cent_y, x_circ, y_circ);
         
         float value = data.getPoint(i).getValue();
         
         data_x_pts.add(cent_x + value*pix_to_value * cos(angle));
         data_y_pts.add(cent_y + value*pix_to_value * sin(angle)); 
         angle += degree_inc;
         
      }
     
      //draw data points on radar graph x,y coordinate parallel arrays
      beginShape();
      fill(176,196,222, 55);
      for(int i = 0; i < data.size() ; i++){
         if ( i != data.size() - 1){
           stroke(data_c);
           line(data_x_pts.get(i), data_y_pts.get(i), data_x_pts.get(i+1), data_y_pts.get(i+1));
         } else {
           //draws line from last data to first data
           line(data_x_pts.get(i), data_y_pts.get(i), data_x_pts.get(0), data_y_pts.get(0));
         }
         //records each as vertex for filling
         vertex(data_x_pts.get(i), data_y_pts.get(i));
      }
      endShape();
      
      // dots
      noStroke();
      fill(255, 255, 0);
      for(int i = 0; i < data.size() ; i++){
        if (data.getPoint(i).isMarked()) {
            ellipse(data_x_pts.get(i), data_y_pts.get(i), 7, 7);
        }
      }  
  }
}