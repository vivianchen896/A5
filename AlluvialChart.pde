public class AlluvialChart extends Chart {
  
  AlluvialChart (Data data, int chartX, int chartY, int chartWidth, int chartHeight) {
   super(data, chartX, chartY, chartWidth, chartHeight);
    this.name = "Alluvial";
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
    
    float left_circle_x = this.viewX + this.viewWidth/6;
    float left_circle_y = this.viewY + this.viewHeight/2;
    float left_circle_d = 25;

    float ratio_sum = 0;
    float spacing_total = this.viewHeight/5;
    float content_total = 4*this.viewHeight/5;
    ArrayList<Float>ratios = new ArrayList<Float>();
    
    // calculate spacing for circles
    for (int i = 0; i < data.size(); i++) {
      float value = data.getPoint(i).getValue();
      float first_val = data.getPoint(0).getValue();
      float ratio = sqrt(value / first_val);
      
      ratio_sum += ratio;
      ratios.add(ratio);
    }
    
    float first_d = content_total / ratio_sum;
    float max_ratio = find_max(ratios);
    float x_margin = max_ratio * first_d / 2 + 10;
    float y_margin = spacing_total / (data.size() +1 );
    float curr_r = 0;
    float accum_y = this.viewY;
    float stroke_scale = 20 / this.data.yMax();
    
    for (int i  = 0; i < data.size(); i++) {
      curr_r = ratios.get(i) * first_d / 2;
      float curr_x = this.viewX + this.viewWidth - x_margin;
      float curr_y = accum_y + y_margin + curr_r;   
      
      // bezier curves
      float value = data.getPoint(i).getValue();
      float stroke = value * stroke_scale;
      noFill();
      strokeWeight(stroke);
      bezier(left_circle_x, left_circle_y, curr_x-100, left_circle_y, left_circle_x+100, curr_y, curr_x, curr_y);
      strokeWeight(1);
      
      // circles
      fill(176,196,222);
      ellipse(curr_x, curr_y, curr_r*2, curr_r*2);
      
      accum_y += y_margin + curr_r + curr_r;  
    } 
    
    // draw left circle
    ellipse(left_circle_x, left_circle_y, left_circle_d, left_circle_d);
  }
}


float find_max(ArrayList<Float>l) {
  float m = 0;
  for (Float num : l) {
    if (num > m) {
      m = num;
    }
  }
  return m;
}