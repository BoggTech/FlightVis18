class DebugScreen extends Screen {
  final int EVENT_BUTTON = 1;
  // quick debug screen to make an example on how to make new ones
  Button button;
  Button button2;
  Button button3;
  PieChart pieChart;
  DataReader dataReader;
  Slider slider;
  Slider slider2;

  double lastTimestamp;
  double thisTimestamp;
  double actualFrameRate;

  DebugScreen() {
    // call the super constructor; sets up basic screen stuff.
    super();
    lastTimestamp = millis();
    thisTimestamp = millis();

    float[] data = {0, 100};
    String[] labels = {"one", "two"};

    // button
    button = new Button(560, 10, 20, 20);
    button.setEvent(GLOBAL_EVENT_RIGHT);
    button2 = new Button(10, 10, 20, 20);
    button2.setEvent(GLOBAL_EVENT_LEFT);
    button3 = new Button(10, 40, 20, 20);
    button3.setEvent(1);

    pieChart = new PieChart(data, labels, 200, 150, 150);
    slider = new Slider(150, 300, 300, 50);
    slider2 = new Slider(0, 360, 600, 50);
    addWidget(button);
    addWidget(pieChart);
    addWidget(slider);
    addWidget(slider2);
    addWidget(button2);
    addWidget(button3);
  }

  void draw() {
    fill(255);
    textSize(32);
    text("succeeded: " + pieChart.data[0] + "\nfailed: " + pieChart.data[1], getX()+300, getY()+50);
    screen.checkCollisions(mouseX, mouseY);
    pieChart.data[0] = 100 * slider.getProgress();
    pieChart.data[1] = 100 - (100 * slider.getProgress());
    pieChart.setup();
    super.draw();

    // framerate
    fill(0);
    if ( frameCount % 60 == 0 ) {
      actualFrameRate = round(frameRate);
    }
    text("" + actualFrameRate, getX(), getY() + 600);
  }

  boolean handleEvent(int event) {
    switch ( event ) {
    case EVENT_BUTTON:
      println("This button is handled within the screen object!");
      return false;
    default:
      // return true on global events; "everything else"
      return true;
    }
  }
}
