public class Data{

  private int size;
  private DataPoint[] dataPoints;
  private int pointOne, pointTwo;
  private float yMax;
  private float total = 0;

  public Data(int size){
    this.size = size;
    this.dataPoints = new DataPoint[size];
    assert (this.size >= 2);
    
    // Set pointOne
    this.pointOne = int(random(0, this.size - 1));
    this.pointTwo = this.pointOne;
    
    // Ensure pointTwo is different than pointOne
    while (this.pointTwo == this.pointOne) {
      this.pointTwo = int(random(0, this.size - 1));
    }
  }
  
  public DataPoint getPointOne() {
    return this.dataPoints[this.pointOne];
  }
  
  public DataPoint getPointTwo() {
    return this.dataPoints[this.pointTwo];
  }
  
  public float getPointPercentage() {
    float minPoint = min(this.getPointOne().value, this.getPointTwo().value);
    float maxPoint = max(this.getPointOne().value, this.getPointTwo().value);
    
    return minPoint / maxPoint;
  }
  
  public void setPoint(int index, float value, boolean isMarked) {
    this.dataPoints[index] = new DataPoint(value, isMarked);
    this.yMax = 0;
    this.total += value;
    
    if (index == this.pointOne || index == this.pointTwo) {
      this.dataPoints[index].setMarked();
    }
    
    for (int i = 0; i < this.size(); i++) {
      if (this.dataPoints[i] != null) {
        this.yMax = max(this.yMax, this.dataPoints[i].getValue());
      }
    }
  }

  public int size(){
    return this.size;
  }
  
  public float yMax() {
    return this.yMax;
  }
  
  public float total() {
    return this.total; 
  }
  
  public DataPoint getPoint(int index) {
    assert (index < size && index >= 0);
    return this.dataPoints[index]; 
  }

  private class DataPoint{
    private float value;
    private boolean isMarked;

    public DataPoint(float value, boolean isMarked){
      this.value = value;
      this.isMarked = isMarked;
    }

    public boolean isMarked(){
      return this.isMarked;
    }
    
    public void setMarked() {
      this.isMarked = true; 
    }

    public float getValue(){
      return this.value;
    }

  }
}