// DEBUG SCREENS
// Moving these into one file, its getting very cramped
// Nothing interesting, just a playground for testing widgets.

// DEBUG SCREEN 1
class DebugScreen extends Screen {
  final int EVENT_BUTTON = 1;
  TextWidget pieChartText, fpsText;
  
  // quick debug screen to make an example on how to make new ones
  Button button, button2, button3, button4;
  PieChart pieChart;
  Slider slider, slider2;
  double actualFrameRate;

  DebugScreen() {
    // call the super constructor; sets up basic screen stuff.
    super();
    //dataFile.testFunction();
    
    pieChartText = new TextWidget("AgencyFB-Bold", "", 32, 300, 50, 400, 300);
    fpsText = new TextWidget("AgencyFB-Bold", "-1.0", 32, 5, 560, 64, 200);
    fpsText.setDrawBackground(true);

    float[] data = {0, 100};
    String[] labels = {"one", "two"};
    color[] colors = {color(255, 8, 2), color(47, 28, 94)};

    // button
    button = new Button(10, 10, 20, 20);
    button.setEvent(GLOBAL_EVENT_RIGHT);
    button.setLabel(" R");
    
    button2 = new Button(520, 10, 20, 20);
    button2.setEvent(GLOBAL_EVENT_LEFT);
    button2.setLabel(" L");
    
    button3 = new Button(10, 40, 20, 20);
    button3.setEvent(1);
    button3.setLabel(" P");

    button4 = new Button(10, 70, 30, 30);
    button4.setEvent(GLOBAL_EVENT_DEBUG_3);
    button4.setLabel(" >");

    pieChart = new PieChart(data, labels, colors, 200, 150, 150);
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
    addWidget(pieChartText);
    addWidget(fpsText);
  }

  void draw() {
    pieChartText.setLabel("succeeded: " + pieChart.data[0] + "\nfailed: " + pieChart.data[1]);
    pieChart.data[0] = 100 * slider.getProgress();
    pieChart.data[1] = 100 - (100 * slider.getProgress());
    pieChart.setup();
    fill(0);
    if ( frameCount % 60 == 0 ) {
      actualFrameRate = round(frameRate);
    }
    fpsText.setLabel("" + actualFrameRate);
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

//-----------------------------------------------------------------------------------//

// DEBUG SCREEN 2
class DebugScreen2 extends Screen {
  Button button, button2;
  TextWidget pieChartText, averageDistance;
  PieChart pieChart;
  final int EVENT_TOGGLEDATA = 1;
  String label = "Cancelled";

  int totalFlights;
  int cancelledFlights;
  int divertedFlights;

  DebugScreen2() {
    super();
    button = new Button(10, 70, 30, 30);
    button.setEvent(GLOBAL_EVENT_DEBUG_1);
    button.setLabel(" <");

    button2 = new Button(10, 110, 30, 30);
    button2.setEvent(EVENT_TOGGLEDATA);
    button2.setLabel(" o");
    button2.setColor(color(85, 23, 95));

    totalFlights = dataFile.getTotal();
    cancelledFlights = dataFile.getTotalCancelled();
    divertedFlights = dataFile.getTotalDiverted();

    float[] data = {cancelledFlights, totalFlights-cancelledFlights};
    String[] labels = {"one", "two"};
    color[] colors = {color(255, 0, 0), color(0, 255, 0)};

    pieChart = new PieChart(data, labels, colors, 200, 150, 150);
    
    pieChartText = new TextWidget("AgencyFB-Bold", "", 32, 300, 50, 400, 300);
    pieChartText.setLabel(label + ": " + round(pieChart.data[0]) + "\nOther: " + round(pieChart.data[1]));
    
    averageDistance = new TextWidget("AgencyFB-Bold", "", 32, 50, 300, 500, 300);
    averageDistance.setLabel("Average Distance: " + dataFile.getAverageDistance() + " km" 
    + "\nTotal Flights: " + totalFlights);

    addWidget(button);
    addWidget(button2);
    addWidget(pieChart);
    addWidget(pieChartText);
    addWidget(averageDistance);
  }

  void draw() {
    super.draw();
  }

  boolean handleEvent(int event) {
    switch ( event ) {
    case 1:
      if ( label.equals("Cancelled") ) {
        pieChart.data[0] = divertedFlights;
        pieChart.data[1] = totalFlights - divertedFlights;
        label = "Diverted";
      } else {
        pieChart.data[0] = cancelledFlights;
        pieChart.data[1] = totalFlights - cancelledFlights;
        label = "Cancelled";
      }
      pieChartText.setLabel(label + ": " + round(pieChart.data[0]) + "\nOther: " + round(pieChart.data[1]));
      pieChart.setup();
      return false;
    default:
      return true;
    }
  }
}

class SearchScreen extends Screen {
  SearchBar searchBar = new SearchBar(0, 0, SCREENX, 100);
  SearchScreen() {
    addWidget(searchBar);
    
  }
}
