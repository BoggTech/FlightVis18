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
    mapButton.setLabel("View Map");
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
  
  Button date = new Button(0, 0, 200, 100);
  Button arrivalTime = new Button(0, 101, 200, 100);
  Button searchButton = new Button(800, 0, 100, 100);
  Button depTime = new Button(0, 202, 200, 100);
  Button origin = new Button(0, 303, 200, 100);
  Button destination = new Button(0, 404, 200, 100);
  Button flightNumber = new Button(0, 505, 200, 100);
  SearchBar searchBar = new SearchBar(201, 0, SCREENX - 300, 100);
  SearchScreen() {
    addWidget(searchBar);
    addWidget(searchButton);
    searchButton.setEvent(SEARCH_EVENT_7);
    
    //date Button
    addWidget(date);
    date.setLabel("Date");
    date.setLabelSize(35);
    date.setAlign(CENTER);
    date.moveLabel(0, -10);
    date.moveLabel(0, 0);
    date.setLabelColor(TEXT_COLOR);
    date.setEvent(SEARCH_EVENT_1);
    
    // arrival time filter
    addWidget(arrivalTime);
    arrivalTime.setLabel("Arrival");
    arrivalTime.setLabelSize(35);
    arrivalTime.setAlign(CENTER);
    arrivalTime.moveLabel(0, -10);
    arrivalTime.moveLabel(0, 0);
    arrivalTime.setLabelColor(TEXT_COLOR);
    arrivalTime.setEvent(SEARCH_EVENT_2);
    
    addWidget(depTime);
    depTime.setLabel("Departure");
    depTime.setLabelSize(35);
    depTime.setAlign(CENTER);
    depTime.moveLabel(0, -10);
    depTime.moveLabel(0, 0);
    depTime.setLabelColor(TEXT_COLOR);
    depTime.setEvent(SEARCH_EVENT_3);
    
    addWidget(origin);
    origin.setLabel("Origin");
    origin.setLabelSize(35);
    origin.setAlign(CENTER);
    origin.moveLabel(0, -10);
    origin.moveLabel(0, 0);
    origin.setLabelColor(TEXT_COLOR);
    origin.setEvent(SEARCH_EVENT_4);
    
    addWidget(destination);
    destination.setLabel("Destination");
    destination.setLabelSize(35);
    destination.setAlign(CENTER);
    destination.moveLabel(0, -10);
    destination.moveLabel(0, 0);
    destination.setLabelColor(TEXT_COLOR);
    destination.setEvent(SEARCH_EVENT_5);
    
    addWidget(flightNumber);
    flightNumber.setLabel("Flight No.");
    flightNumber.setLabelSize(35);
    flightNumber.setAlign(CENTER);
    flightNumber.moveLabel(0, -10);
    flightNumber.moveLabel(0, 0);
    flightNumber.setLabelColor(TEXT_COLOR);
    flightNumber.setEvent(SEARCH_EVENT_6);
  }
}

// ---------------- MAP ----------------
class MapScreen extends Screen {
  MapScreen() {
    super();
    addWidget(new MapWidget(0, 0, 200, 200, "usa-wikipedia.svg"));
  }
}
