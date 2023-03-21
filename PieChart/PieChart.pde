public class pieChart {
  //variables used for chart, each index of the int array will be something such as
  //airport or state and are to be put into the labels array, the numbers at each
  //index will represent data such as number of flights.
  private int xpos;
  private int ypos;
  private int diameter;
  float[] data;
  String[] labels;
  private float sum;

  pieChart(float[]data, String[] labels, int diameter, int ypos, int xpos) {
    this.xpos=xpos;
    this.ypos=ypos;
    this.diameter=diameter;
    this.data=data;
    this.labels=labels;
    sum=0;
  }

  void setup() {
    for (int i=0; i<data.length; i++) {
      sum=data[i]+sum;
    }
  }

  //map() will give varying colours between the range 0-255, this will get different
  //colours for the sectors, allowing users to distinguish between the sectors

  //arc() draws the arc for the current index, and the radians() will ensure the arcs
  //will always form a circle no matter the number of indices or the magnitude in each
  //one

  void draw() {
    int lastAngle=0;
    for (int i=0; i<data.length; i++) {
      float colour = map(i, 0, data.length, 200, 255);
      fill(colour);
      arc(xpos/2, ypos/2, diameter, diameter, lastAngle,
        lastAngle+radians(data[i]*360/sum)); //issue with positions of sectors 3/21 7:50pm
      lastAngle+=radians(data[i]*360/sum);
    }
  }
}
