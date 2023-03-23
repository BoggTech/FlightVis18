final int SCREENX = 600;
final int SCREENY = 600;

Screen screen;
Widget button;
PieChart pieChart;
DataReader dataReader;

int failed;
int succeeded;
int index;



void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  dataReader = new DataReader();
  failed = 0;
  succeeded = 0;
  for ( int i = 0; i < dataReader.flightObjects.size(); i++ ) {
    if ( dataReader.flightObjects.get(i).getCancelled() == 1.0 )
      failed++;
    else
      succeeded++;
  }

  screen = new Screen();
  float[] data = {failed, succeeded};
  String[] labels = {"one", "two"};

  button = new Button(10, 10, 20, 20);
  button.setEvent(1);
  pieChart = new PieChart(data, labels, 200, 300, 300);

  screen.addWidget(button);
  screen.addWidget(pieChart);
}

void draw() {
  background(100);

  fill(255);
  textSize(32);
  text("succeeded: " + succeeded + "\nfailed: " + failed, 300, 50);
  screen.checkCollisions(mouseX, mouseY);
  screen.draw();
}

void mousePressed() {
  screen.mousePressed(mouseX, mouseY);
  int event = screen.getEvent(mouseX, mouseY);
  switch( event ) {
  case 1:
    failed = int(random(1, 1000));
    succeeded = int(random(1, 1000));
    pieChart.data[0] = failed;
    pieChart.data[1] = succeeded;
    pieChart.setup();
  case -1:
    break;
  }
}
