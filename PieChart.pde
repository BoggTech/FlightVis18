public class PieChart extends Widget {
  //variables used for chart, each index of the int array will be something such as
  //airport or state and are to be put into the labels array, the numbers at each
  //index will represent data such as number of flights.
  private int diameter;
  float[] data;
  String[] labels;
  private float sum;

  PieChart(float[]data, String[] labels, int diameter, int xpos, int ypos) {
    super(xpos, ypos, 0, 0);
    this.diameter=diameter;
    this.data=data;
    this.labels=labels;
    sum=0;
    setup();
  }

  void setup() {
    sum = 0;
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
    stroke(0);
    float lastAngle=0;
    for (int i=0; i<data.length; i++) {
      float colour = map(i, 0, data.length, 0, 255);
      fill(colour);
      arc(getEffectiveX(), getEffectiveY(), diameter, diameter, lastAngle,
        lastAngle+radians(data[i]*360/sum));
      lastAngle+=radians(data[i]*360/sum);
    }
  }
}
