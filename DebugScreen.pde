class DebugScreen extends Screen {
  final int EVENT_BUTTON = 1;
  // quick debug screen to make an example on how to make new ones
  Button button, button2, button3, button4;
  PieChart pieChart;
  DataReader dataReader;
  Slider slider;
  Slider slider2;
  double actualFrameRate;

  DebugScreen() {
    // call the super constructor; sets up basic screen stuff.
    super();

    float[] data = {0, 100};
    String[] labels = {"one", "two"};

    // button
    button = new Button(10, 10, 20 , 20);
    button.setEvent(GLOBAL_EVENT_RIGHT);
    button2 = new Button(520, 10, 20, 20);
    button2.setEvent(GLOBAL_EVENT_LEFT);
    button3 = new Button(10, 40, 20, 20);
    button3.setEvent(1);
    
    button4 = new Button(10, 70, 30, 30);
    button4.setEvent(GLOBAL_EVENT_DEBUG_2);
    
    

    pieChart = new PieChart(data, labels, 200, 150, 150);
    slider = new Slider(150, 300, 300, 50);
    slider2 = new Slider(0, 360, 600, 50);
    
    // note: dont do this. use arrays. this is just a test page.
    addWidget(button);
    addWidget(pieChart);
    addWidget(slider);
    addWidget(slider2);
    addWidget(button2);
    addWidget(button3);
    addWidget(button4);
  }

  void draw() {
    fill(255);
    textSize(32);
    text("succeeded: " + pieChart.data[0] + "\nfailed: " + pieChart.data[1], getX()+300, getY()+50);
    pieChart.data[0] = 100 * slider.getProgress();
    pieChart.data[1] = 100 - (100 * slider.getProgress());
    pieChart.setup();

    // framerate
    fill(0);
    if ( frameCount % 60 == 0 ) {
      actualFrameRate = round(frameRate);
    }
    text("" + actualFrameRate, getX(), getY() + 600);
    super.draw();
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