//class for a radar graph that has four concentric circles and five categorical values
//max value is 200, min 0

float w = width/2;
float h = height/2;
int max = 200;

class Radar{
    //center x,y point for radar chart
    float cent_x;
    float cent_y;
    int[] data;
    int num_circle = 4;
    int num_categories = 5;
    color data_c = color(100,149,237);
    public Radar(int[] data_vals){
        cent_x = width/2;
        cent_y = height/2;
        data = data_vals;
        draw_radar();
    }
    
    void draw_radar(){
      noFill();
      float buffer = ( height/2 )/num_circle;
      float diameter = height/2;
      int val_inc = max/num_circle;
      int val = 0;
      
      //four concentric circles wiht a distance of buffer in between
      beginShape();
      for(int i = 0; i <= num_circle; i++){
        stroke(0);
        ellipse(cent_x, cent_y, diameter, diameter);
        
        //draw the increments on radar chart
        fill(0);
        text(val, cent_x, cent_y - val);
        noFill();
        
        val += val_inc;
        diameter -= buffer;
      }
      endShape();
      
      float degree_inc = (2 * PI)/num_categories; 
      //the end point on circle circumference
      float x_circ;
      float y_circ;
      float angle = -PI/2;
      //arrays to store all data coordinates on radard graph
      float[] data_x_pts = {0, 0, 0, 0, 0};
      float[] data_y_pts = {0, 0, 0, 0, 0};
      
      //draw the expanding lines from the center
      for(int i = 0; i < num_categories; i++){
         x_circ = cent_x + height/4 * cos(angle);
         y_circ = cent_y + height/4 * sin(angle);
         stroke(0);   
         line( cent_x, cent_y, x_circ, y_circ);
         
         data_x_pts[i] = cent_x + (float)data[i] * cos(angle);
         data_y_pts[i] = cent_y + (float)data[i] * sin(angle); 
         angle += degree_inc;
         
      }
     
      //draw data points on radar graph x,y coordinate parallel arrays
    
      beginShape();
      fill(176,196,222, 55);
      for(int i = 0; i < num_categories ; i++){
         if ( i != num_categories - 1){
           stroke(data_c);
           line(data_x_pts[i], data_y_pts[i], data_x_pts[i + 1], data_y_pts[i + 1]);
         } else {
           //draws line from last data to first data
           line(data_x_pts[i], data_y_pts[i], data_x_pts[0], data_y_pts[0]);
         }
         //records each as vertex for filling
         vertex(data_x_pts[i], data_y_pts[i]);
      }
      endShape(CLOSE);
    }
}