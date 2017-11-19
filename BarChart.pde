public class BarChart extends Chart {
  
  BarChart (Data data, int chartX, int chartY, int chartWidth, int chartHeight) {
   super(data, chartX, chartY, chartWidth, chartHeight);
    this.name = "Bar";
    
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
    float xScale = this.viewWidth / ((this.data.size() * 2) + 1);
    float yScale = this.viewHeight / this.data.yMax();
    
    for (int index = 0; index < data.size(); index++) {
      float value = data.getPoint(index).getValue();
      float yHeight = value * yScale;
      float startX = this.viewX + (((2 * index) + 1) * xScale);
      float startY =  this.viewY + this.viewHeight - yHeight;
      
      fill(0);
      rect(startX, startY, xScale, yHeight);
      
      // dots
      if (data.getPoint(index).isMarked()) {
        fill(255, 255, 0);
        ellipse(startX + (xScale/2), startY + 10, 6, 6);
      }
    }
  }
}