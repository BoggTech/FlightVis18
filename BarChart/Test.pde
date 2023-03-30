float[] data;
color[] colors;
color red;
color green;
barChart theBarChart;

void setup(){
  float[] data= {30,50,60, 95, 90};
  red = color(255,0,0);
  green = color(0,255,0);
  color[] colors= {red, green, red, green, green};
  size(600,600);
  theBarChart = new barChart(data, colors, 100,100, 10, 100,100);
  theBarChart.setup();
}

void draw(){
  background(255);
  theBarChart.draw();
  
}
