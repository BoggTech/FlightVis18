// ---------------- MENU ----------------
class MenuScreen extends Screen {
  final int LOGOX = SCREENX/2-250;
  final int LOGOY = SCREENY/2-280;
  final int TEXT_START = 175;

  TextWidget title;
  Button mapButton, searchButton;
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

    addWidget(title);
    addWidget(searchButton);
    addWidget(mapButton);
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
    addWidget(new MapWidget(25, 25, SCREENX-50, SCREENY-100, "usa-wikipedia.svg"));
  }

  void draw() {
    super.draw();
  }
}
