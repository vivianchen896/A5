public class PieChart extends Chart {
  
  PieChart (Data data, int chartX, int chartY, int chartWidth, int chartHeight) {
   super(data, chartX, chartY, chartWidth, chartHeight);
    this.name = "Pie";
  }
  
  float calculateXLabelWidth() {
    return 80.0; 
  }
  
  float calculateYLabelWidth() {
    return 80.0;
  }
  
  @Override
  public void draw() {

    rect(this.viewX, this.viewY, this.viewWidth, this.viewHeight);

    
    float diameter = min(this.viewWidth, this.viewHeight);
    int x = this.viewX + (this.viewWidth/2);
    int y = this.viewY + (this.viewHeight/2);
    
    strokeWeight(1);
    
    float currTheta = 0;

    stroke(0);
    
    for (int index = 0; index < data.size(); index++) {
      float value = data.getPoint(index).getValue();
        
      // Draw the pie!
      float arcTheta = (value/data.total()) * TWO_PI;
              
      fill(255, 45, 45);
      arc(x, y, diameter, diameter, currTheta, currTheta + arcTheta, PIE);
      
      if (data.getPoint(index).isMarked()) {
        fill(237, 255, 76);
        ellipse(x + cos(currTheta + (arcTheta / 2)) * (diameter / 4), y + sin(currTheta + (arcTheta / 2)) * (diameter / 4), 6, 6);
      }
      
      currTheta += arcTheta;
      
    }
  }
}