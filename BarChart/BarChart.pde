public class BarChart {
  int[] data;
  color[] colors;
  int lengthOfLine;
  int heightOfLine;
  float gap;
  int maxNumber;
  float lengthOfEachSquare;
  float xpos;
  int ypos;

  int heightOfLine;
  float gap) {
    this.data=data;
    this.colors=colors;
    this.lengthOfLine = lengthOfLine;
    this.heightOfLine=heightOfLine;
    this.gap=gap;
    this.xpos=xpos;
    this.ypos=ypos;
  }

  void setup() {
    int temp = gap*(data.length-1);
    temp=lengthOfLine-temp;
    lengthOfEachSquare = temp/data.length;
  }
}
