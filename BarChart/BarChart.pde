class barChart {
  float[] data;
  color[] colors;
  float lengthOfLine;
  float heightOfLine;
  float gap;
  float maxNumber;
  float lengthOfEachSquare;
  float xpos;
  float ypos;
  float temp;
  float originalXpos;

  barChart(float[] data, color[] colors, float lengthOfLine,
    float heightOfLine, float gap, float xpos, float ypos) {
    this.data=data;
    this.colors=colors;
    this.lengthOfLine = lengthOfLine;
    this.heightOfLine=heightOfLine;
    this.gap=gap;
    this.xpos=xpos;
    this.ypos=ypos;
  }

  void setup() {
    temp = gap*(data.length-1);
    temp=lengthOfLine-temp;
    lengthOfEachSquare = temp/data.length;
    maxNumber=1;
    for (int i=0; i<data.length; i++) {
      if (data[i]>maxNumber) maxNumber=data[i];
    }
    originalXpos = xpos;
  }

  void draw() {
    for (int i=0; i<data.length; i++) {
      color colour = colors[i];
      rect(xpos, ypos+maxNumber-(heightOfLine*(data[i]/maxNumber)), lengthOfEachSquare, heightOfLine*(data[i]/maxNumber));
      fill(colour);
      xpos=xpos+lengthOfEachSquare+gap;
      if(i==data.length-1) xpos = originalXpos;
    }
  }
}
