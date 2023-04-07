// ---------------- MENU ----------------
class MenuScreen extends Screen {
  final int LOGOX = SCREENX/2-250;
  final int LOGOY = SCREENY/2-280;
  final int TEXT_START = 175;
  final int buttonMargin = 25;

  TextWidget title;
  Button mapButton, searchButton, overviewButton;
  final int buttonHeight = 100;
  int totalFlights;
  MenuScreen() {
    super();

    String pcName = System.getProperty("user.name");

    totalFlights = dataFile.getTotal();
    String newString = fancyNumber(totalFlights);
    title = new TextWidget("", "Welcome, " + pcName
      + ". \nThere have been " + newString + " flight in the past month."
      + "\nPlease see available options below.", 32, 10, TEXT_START, SCREENX, 256);
    title.setAlign(CENTER);

    
    
    int buttonCount = 3;
    int freeSpace = SCREENX - (buttonCount+1)*buttonMargin;
    int buttonWidth = freeSpace/buttonCount;

    searchButton = new Button(buttonMargin*1+(freeSpace/buttonCount)*0, SCREENY-(buttonHeight+buttonMargin), buttonWidth, buttonHeight);
    searchButton.setLabel("Search");
    searchButton.setLabelSize(48);
    searchButton.setAlign(CENTER);
    searchButton.moveLabel(0, -10);
    searchButton.setLabelColor(TEXT_COLOR);
    searchButton.setEvent(GLOBAL_EVENT_SEARCH_SCREEN);

    overviewButton = new Button(buttonMargin*2+(freeSpace/buttonCount)*1, SCREENY-(buttonHeight+buttonMargin), buttonWidth, buttonHeight);
    overviewButton.setLabel("Overview");
    overviewButton.setLabelSize(48);
    overviewButton.setAlign(CENTER);
    overviewButton.moveLabel(0, -10);
    overviewButton.setLabelColor(TEXT_COLOR);
    overviewButton.setEvent(GLOBAL_EVENT_OVERVIEW_SCREEN);
    
    mapButton = new Button(buttonMargin*3+(freeSpace/buttonCount)*2, SCREENY-(buttonHeight+buttonMargin), buttonWidth, buttonHeight);
    mapButton.setLabel("Map");
    mapButton.setLabelSize(48);
    mapButton.setAlign(CENTER);
    mapButton.moveLabel(0, -10);
    mapButton.moveLabel(0, 0);
    mapButton.setLabelColor(TEXT_COLOR);
    mapButton.setEvent(GLOBAL_EVENT_MAP_SCREEN);


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
  Button backButton;
  SearchScreen() {
    addWidget(searchBar);
    
    backButton = new Button(25, SCREENY-65, 80, 55);
    backButton.setLabel("BACK");
    backButton.setAlign(CENTER);
    backButton.setLabelSize(24);
    backButton.moveLabel(0, -3);
    backButton.setEvent(GLOBAL_EVENT_MENU_SCREEN);
    addWidget(backButton);
  }
}

// ---------------- MAP ----------------
class MapScreen extends Screen {
  String formatString = "%s\nTotal Flights: %s\nDiverted: %s\nCancelled: %s\n";
  MapWidget map;
  Button backButton, closeInfoButton;
  TextWidget stateLabel, infoLabel;
  Widget info;
  String currentState;
  Boolean drag;
  String total, diverted, cancelled;

  MapScreen() {
    super();
    map = new MapWidget(25, 25, SCREENX-50, SCREENY-100, "usa-wikipedia.svg");
    map.setColor(color(0));

    drag = false;

    backButton = new Button(25, SCREENY-65, 80, 55);
    backButton.setLabel("BACK");
    backButton.setAlign(CENTER);
    backButton.setLabelSize(24);
    backButton.moveLabel(0, -3);
    backButton.setEvent(GLOBAL_EVENT_MENU_SCREEN);

    stateLabel = new TextWidget("", "test", 48, SCREENX-600, SCREENY-65, 600, 65);
    stateLabel.move(-25, -6);
    stateLabel.setAlign(RIGHT);

    info = new Widget(SCREENX/2-250, SCREENY/2-250, 500, 500);
    info.setSelectedBorderColor(info.getDefaultBorderColor());
    infoLabel = new TextWidget(10, 10, int(info.getWidth()-10), int(info.getHeight()-40));
    infoLabel.setLabel(formatString);
    info.addChild(infoLabel);
    info.hide();
    
    closeInfoButton = new Button(info.getWidth()-100, info.getHeight()-50, 90, 40);
    closeInfoButton.setLabel("BACK");
    closeInfoButton.setAlign(CENTER);
    closeInfoButton.setLabelSize(24);
    closeInfoButton.moveLabel(0, -3);
    info.addChild(closeInfoButton);



    
    addWidget(map);
    addWidget(backButton);
    addWidget(stateLabel);
    addWidget(info);
  }

  void draw() {
    String state = map.getSelectedState();
    if ( state != null ) {
      if ( currentState != state ) {
        stateLabel.setLabel(map.getFullStateName(state));
      }
    } else {
      stateLabel.setLabel("N/A");
    }
    super.draw();
  }

  void onMouseReleased(int mouseX, int mouseY) {
    String state = map.getSelectedState();
    if ( drag ) {
      drag = false;
      return;
    }
    if ( state != null && !info.shown && map.isTouching(mouseX, mouseY)) {
      map.setActive(false);
      total = fancyNumber(dataFile.countTotalState(state));
      diverted = fancyNumber(dataFile.countDivertedState(state));
      cancelled = fancyNumber(dataFile.countCancelledState(state));
      infoLabel.setLabel(String.format(formatString, map.getFullStateName(state), total, diverted, cancelled));
      info.show();
    } else {
      Button button = (Button) info.getChild(1);
      if ( button.isTouching(mouseX, mouseY) ) {
        map.setActive(true);
        map.checkCollisions(mouseX, mouseY);
        info.hide();
      }
    }
  }

  void onMouseDragged(int mouseX, int mouseY, int pmouseX, int pmouseY) {
    drag = true;
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
  Button backButton;
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
    
    backButton = new Button(25, SCREENY-65, 80, 55);
    backButton.setLabel("BACK");
    backButton.setAlign(CENTER);
    backButton.setLabelSize(24);
    backButton.moveLabel(0, -3);
    backButton.setEvent(GLOBAL_EVENT_MENU_SCREEN);
    addWidget(backButton);
  }

  boolean handleEvent(int event) {
    switch(event) {
    default:
      return true;
    case 1:
      if (flights[0]==0) flights[0]=cancelledFlights;
      else flights[0]=0;
      thePieChart.setup();
      println(flights[0]);
      return false;
    case 2:
      if (flights[1]==0) flights[1]=notCancelled;
      else flights[1]=0;
      thePieChart.setup();
      println(flights[1]);
      return false;
    case 3:
      if (flights[2]==0) flights[2]=diverted;
      else flights[2]=0;
      thePieChart.setup();
      return false;
    }
  }
}
