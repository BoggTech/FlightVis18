// ---------------- MENU ----------------
class MenuScreen extends Screen {
  final int LOGOX = SCREENX/2-250;
  final int LOGOY = SCREENY/2-280;
  final int TEXT_START = 175;

  TextWidget title;
  Button mapButton, searchButton, overviewButton;
  final int buttonHeight = 100;
  int totalFlights;
  MenuScreen() {
    super();

    String pcName = System.getProperty("user.name");

    totalFlights = dataFile.getTotal();
    String totalFlightsString = Integer.toString(totalFlights);
    String newString = "";

    // getting fancy number with commas)
    for ( int i = totalFlightsString.length(); i > 3; i -= 3 ) {
      String cut = totalFlightsString.substring(totalFlightsString.length()-3, totalFlightsString.length());
      totalFlightsString = totalFlightsString.substring(0, totalFlightsString.length()-3);
      newString =  "," + cut + newString;
    }
    newString = totalFlightsString + newString;
    title = new TextWidget("", "Welcome, " + pcName
      + ". \nThere have been " + newString + " flight in the past month."
      + "\nPlease see available options below.", 32, 10, TEXT_START, SCREENX, 256);
    title.setAlign(CENTER);

    mapButton = new Button(0, SCREENY-buttonHeight, SCREENX/2-1, buttonHeight);
    mapButton.setLabel("Interactive Map");
    mapButton.setLabelSize(64);
    mapButton.setAlign(CENTER);
    mapButton.moveLabel(0, -10);
    mapButton.moveLabel(0, 0);
    mapButton.setLabelColor(TEXT_COLOR);
    mapButton.setEvent(GLOBAL_EVENT_MAP_SCREEN);

    searchButton = new Button(SCREENX/2, SCREENY-buttonHeight, SCREENX/2-1, buttonHeight);
    searchButton.setLabel("Search Data");
    searchButton.setLabelSize(64);
    searchButton.setAlign(CENTER);
    searchButton.moveLabel(0, -10);
    searchButton.setLabelColor(TEXT_COLOR);
    searchButton.setEvent(GLOBAL_EVENT_SEARCH_SCREEN);

    overviewButton = new Button(SCREENX/2, SCREENY-(buttonHeight*2), SCREENX/2-1, buttonHeight);
    overviewButton.setLabel("Data Overview");
    overviewButton.setLabelSize(64);
    overviewButton.setAlign(CENTER);
    overviewButton.moveLabel(0, -10);
    overviewButton.setLabelColor(TEXT_COLOR);
    overviewButton.setEvent(GLOBAL_EVENT_OVERVIEW_SCREEN);


    addWidget(title);
    addWidget(searchButton);
    addWidget(mapButton);
    addWidget(overviewButton);
  }

  void draw() {
    super.draw();
    fill(TEXT_COLOR);
    textAlign(LEFT, LEFT);
    stroke(getDefaultBorderColor());
    text("FLIGHTVIS", getEffectiveX()+LOGOX+165, getEffectiveY()+LOGOY+90);
    shape(logo, getEffectiveX()+LOGOX, getEffectiveY()+LOGOY);
  }
}

// ---------------- SEARCH ----------------
class SearchScreen extends Screen {
  SearchBar searchBar = new SearchBar(0, 0, SCREENX, 100);
  SearchScreen() {
    addWidget(searchBar);
  }
}

// ---------------- MAP ----------------
class MapScreen extends Screen {
  MapScreen() {
    super();
    //addWidget(new MapWidget(25, 25, SCREENX-50, SCREENY-100, "usa-wikipedia.svg"));
    addWidget(new MapWidget(25, 25, SCREENX-50, SCREENY-100, "usa-wikipedia.svg"));
  }

  void draw() {
    super.draw();
  }
}

// ---------------OVERVIEW----------
class OverviewScreen extends Screen {
  int cancelledFlights = dataFile.getTotalCancelled();
  int diverted = dataFile.getTotalDiverted();
  int notCancelled = dataFile.getTotal() -dataFile.getTotalCancelled() -dataFile.getTotalDiverted();
  float[] flights = {(float)cancelledFlights, (float)notCancelled, (float)diverted};
  color[] colors = {color(255, 0, 0), color(0, 255, 0), color(255, 255, 0)};

  Button success = new Button(600, 50, 250, 100, color(0, 255, 0));
  Button divert = new Button(600, 250, 250, 100, color(255, 255, 0));
  Button cancel = new Button(600, 450, 250, 100, color(250, 0, 0));
  PieChart thePieChart = new PieChart(flights,
    colors, 250, 300, 400);

  OverviewScreen() {
    super();
    addWidget(success);
    addWidget(divert);
    addWidget(cancel);
    success.setLabel("toggle successful");
    success.setLabelSize(24);
    success.setAlign(CENTER);
    success.setEvent(2);
    divert.setLabel("toggle diverted");
    divert.setLabelSize(24);
    divert.setAlign(CENTER);
    divert.setEvent(3);
    cancel.setLabel("toggle cancelled");
    cancel.setLabelSize(24);
    cancel.setAlign(CENTER);
    cancel.setEvent(1);
    addWidget(thePieChart);
  }

  boolean handleEvent(int event) {
    switch(event) {
    default:
      return true;
    case 1:
    if(flights[0]==0) flights[0]=cancelledFlights;
      else flights[0]=0;
      thePieChart.setup();
      println(flights[0]);
      return false;
    case 2:
    if(flights[1]==0) flights[1]=notCancelled;
      else flights[1]=0;
      thePieChart.setup();
      println(flights[1]);
      return false;
    case 3:
      if(flights[2]==0) flights[2]=diverted;
      else flights[2]=0;
      thePieChart.setup();
      return false;
    }
  }
}
