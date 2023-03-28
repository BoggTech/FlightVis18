pieChart thePieChart;
float[] data;
String[] labels;
color red;
color green;

void setup() {
  float[] data = {70, 50};
  String[] labels= {"one", "two"};
  color red = color(255, 0, 0);
  color green = color(0, 255, 0);
  color[] colors= {red, green };
  size(640, 640);
  thePieChart= new pieChart(data, labels, colors, 200, 600, 600);
  thePieChart.setup();
}

void draw() {
  background(50);
  thePieChart.draw();
}
