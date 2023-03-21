pieChart thePieChart;
float[] data;
String[] labels;

void setup() {
  float[] data = {99,1};
  String[] labels= {"one", "two"};
  size(640, 640);
  thePieChart= new pieChart(data, labels, 200, 600, 600);
  thePieChart.setup();
}

void draw(){
  background(50);
  thePieChart.draw();
}
