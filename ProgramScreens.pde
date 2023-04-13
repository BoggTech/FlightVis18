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
      + ". \nThere have been " + newString + " flights in the past month."
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

  Widget info;
  Button result1 = new Button(201, 151, 700, 50);
  Button result2 = new Button(201, 201, 700, 50);
  Button result3 = new Button(201, 252, 700, 50);
  Button result4 = new Button(201, 303, 700, 50);
  Button result5 = new Button(201, 354, 700, 50);
  Button result6 = new Button(201, 405, 700, 50);
  Button result7 = new Button(201, 456, 700, 50);
  Button date = new Button(0, 0, 200, 100);
  Button arrivalTime = new Button(0, 101, 200, 100);
  Button depTime = new Button(0, 202, 200, 100);
  Button origin = new Button(0, 303, 200, 100);
  Button destination = new Button(0, 404, 200, 100);
  Button flightNumber = new Button(0, 505, 200, 100);
  SearchBar searchBar = new SearchBar(201, 0, SCREENX - 202, 100);
  Button nextButton;
  Button prevButton;
  Button backButton;
  Button closeInfoButton;
  TextWidget infoLabel;
  boolean strict;
  int rowNumber;
  String formatString = "%s\n %s\n %s\n %s\n %s\n %s\n";
  String word = "";
  String searchValue = "";
  int searchCount = 30;
  int totalResults = 0;
  String currentId = "";
  String[][] results = null;
  boolean searchOn = false;
  boolean ready = false;
  int resultCount =1;
  int nextCount = 1;
  boolean printData = false;
  String dataAsString = "";
  ArrayList<FlightObject> modifiedObjects = new ArrayList<>();

  SearchScreen() {
    super();
    strict = false;
    results = new String[0][0];

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

    nextButton = new Button(250+90, SCREENY-65, 80, 55); 
    nextButton.setLabel("--->");
    nextButton.setAlign(CENTER);
    nextButton.setLabelSize(24);
    nextButton.moveLabel(0, -3);
    nextButton.setEvent(SEARCH_NEXT);
    addWidget(nextButton);

    prevButton = new Button(250, SCREENY -65, 80, 55);
    prevButton.setLabel("<---");
    prevButton.setAlign(CENTER);
    prevButton.setLabelSize(24);
    prevButton.moveLabel(0, -3);
    prevButton.setEvent(SEARCH_BACK);
    addWidget(prevButton);

    backButton = new Button(SCREENX-80-25, SCREENY-65, 80, 55);
    backButton.setLabel("BACK");
    backButton.setAlign(CENTER);
    backButton.setLabelSize(24);
    backButton.moveLabel(0, -3);
    backButton.setEvent(GLOBAL_EVENT_MENU_SCREEN);
    addWidget(backButton);


    addWidget(searchBar);

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

    result1.setEvent(SEARCH_RESULT1);
    result2.setEvent(SEARCH_RESULT2);
    result3.setEvent(SEARCH_RESULT3);
    result4.setEvent(SEARCH_RESULT4);
    result5.setEvent(SEARCH_RESULT5);
    result6.setEvent(SEARCH_RESULT6);
    result7.setEvent(SEARCH_RESULT7);
  }

  void draw() {
    textSize(35);
    textAlign(LEFT, LEFT);
    // get what range of results we're showing
    int upperBound;
    int lowerBound;
    if ( resultCount+6 > totalResults ) {
      upperBound = totalResults;
    } else {
      upperBound = resultCount+6;
    }
    // edge case
    if ( totalResults == 0 ) {
      lowerBound = 0;
    } else {
      lowerBound = resultCount;
    }
    text("Results " + lowerBound + " - " + upperBound + " out of " + fancyNumber(totalResults), getEffectiveX()+215, getEffectiveY()+135);
    if (printData == true) {
      // this is ugly, and hacky, but i don't have time to
      // rewrite someone's code at 1am
      // this shouldn't run every frame

      // printdata is true if we should print new data, so
      // remove previous results
      removeChild(result1);
      removeChild(result2);
      removeChild(result3);
      removeChild(result4);
      removeChild(result5);
      removeChild(result6);
      removeChild(result7);

      // now show available results
      if ( results.length-resultCount >= 0 ) {
        addWidget(result1);
        result1.setLabel(results[resultCount -1][0] + " | " + results[resultCount -1][5] + " - " + results[resultCount -1][9]);
        result1.setLabelSize(35);
      }

      if ( results.length-resultCount >= 1 ) {
        addWidget(result2);
        result2.setLabel(results[resultCount][0] + " | " + results[resultCount][5] + " - " + results[resultCount][9]);
        result2.setLabelSize(35);
      }

      if ( results.length-resultCount >= 2 ) {
        addWidget(result3);
        result3.setLabel(results[resultCount +1][0] + " | " + results[resultCount +1][5] + " - " + results[resultCount +1][9]);
        result3.setLabelSize(35);
      }


      if ( results.length-resultCount >= 3 ) {
        addWidget(result4);
        result4.setLabel(results[resultCount +2][0] + " | " + results[resultCount +2][5] + " - " + results[resultCount +2][9]);
        result4.setLabelSize(35);
      }

      if ( results.length-resultCount >= 4 ) {
        addWidget(result5);
        result5.setLabel(results[resultCount +3][0] + " | " + results[resultCount +3][5] + " - " + results[resultCount +3][9]);
        result5.setLabelSize(35);
      }

      if ( results.length-resultCount >= 5 ) {
        addWidget(result6);
        result6.setLabel(results[resultCount +4][0] + " | " + results[resultCount +4][5] + " - " + results[resultCount +4][9]);
        result6.setLabelSize(35);
      }

      if ( results.length-resultCount >= 6 ) {
        addWidget(result7);
        result7.setLabel(results[resultCount +5][0] + " | " + results[resultCount +5][5] + " - " + results[resultCount +5][9]);
        result7.setLabelSize(35);
        addWidget(info);
      }

      // render order has changed; put the infobox back on top
      removeChild(info);
      addChild(info);

      // everything is in order
      printData = false;
    }
    super.draw();
  }

  void getResultInfo(int event) {
    // format our info string
    rowNumber = event - 11 + resultCount;
    String flightTrip = results[rowNumber][5] + " - " + results[rowNumber][9];
    String flightDate = "Date : " + results[rowNumber][1];
    String flightDistance = "Distance : " + results[rowNumber][17];
    
    String scheduled = results[rowNumber][14];
    String departure = results[rowNumber][12];
    String arrivalTime = "Scheduled Arrival : " + scheduled.substring(0,2) + ":" + scheduled.substring(2,4);
    String departureTime = "Scheduled Departure : " + departure.substring(0,2) + ":" + departure.substring(2,4);
    String flightNumber = "Flight Number : " + fancyNumber(parseInt(results[rowNumber][0]));
    infoLabel.setLabel(String.format(formatString, flightTrip, flightDate, flightDistance, arrivalTime, departureTime, flightNumber));
  }

  boolean handleEvent(int event) {
    // we'll set this to false if nothing happens
    printData = true;
    if (event >= 10 && event < SEARCH_BACK) {
      getResultInfo(event);
      info.show();
      printData = false;
      return false;
    } else {
      Button button = (Button) info.getChild(1);
      if ( button.isTouching(mouseX, mouseY) ) {
        info.hide();
        printData = false;
        return false;
      }
    }

    switch ( event ) {
    case SEARCH_EVENT_1:
      resetSearch();
      strict = false;
      printData = true;
      results = null;
      resultCount = 1;
      currentId = FLIGHT_DATE;
      totalResults = dataFile.getResultsCount(currentId, searchBar.getResult(), strict);
      results = dataFile.getResults(searchCount, 0, currentId, searchBar.getResult(), strict);
      return false;
    case SEARCH_EVENT_2:
      resetSearch();
      strict = false;
      printData = true;
      results = null;
      resultCount = 1;
      currentId = SCHEDULED_ARRIVAL;
      totalResults = dataFile.getResultsCount(currentId, searchBar.getResult(), strict);
      results = dataFile.getResults(searchCount, 0, currentId, searchBar.getResult(), strict);
      return false;
    case SEARCH_EVENT_3:
      resetSearch();
      strict = false;
      printData = true;
      results = null;
      resultCount = 1;
      currentId = SCHEDULED_DEPARTURE;
      totalResults = dataFile.getResultsCount(currentId, searchBar.getResult(), strict);
      results = dataFile.getResults(searchCount, 0, currentId, searchBar.getResult(), strict);
      return false;
    case SEARCH_EVENT_4:
      resetSearch();
      strict = true;
      printData = true;
      results = null;
      resultCount = 1;
      currentId = ORIGIN_STATE_ABBREVIATION;
      totalResults = dataFile.getResultsCount(currentId, searchBar.getResult(), strict);
      results = dataFile.getResults(searchCount, 0, currentId, searchBar.getResult(), strict);
      return false;
    case SEARCH_EVENT_5:
      resetSearch();
      strict = true;
      printData = true;
      results = null;
      resultCount = 1;
      currentId = DESTINATION_STATE_ABBREVIATION;
      totalResults = dataFile.getResultsCount(currentId, searchBar.getResult(), strict);
      results = dataFile.getResults(searchCount, 0, currentId, searchBar.getResult(), strict);
      return false;
    case SEARCH_EVENT_6:
      resetSearch();
      strict = true;
      printData = true;
      results = null;
      resultCount = 1;
      currentId = "rowid";
      totalResults = dataFile.getResultsCount(currentId, searchBar.getResult(), strict);
      results = dataFile.getResults(searchCount, 0, currentId, searchBar.getResult(), strict);
      return false;
    case SEARCH_EVENT_7:
      resetSearch();
      printData = false;
      searchCount = 30;
      return false;
    case SEARCH_NEXT:
      if ( resultCount+7 < totalResults )
        resultCount = resultCount +7;

      if (nextCount  == 3) {
        searchCount += 30;
        if ( !currentId.equals("") )
          results = dataFile.getResults(searchCount, 0, currentId, searchBar.getResult(), strict);
        nextCount = 1;
      }
      nextCount++;
      return false;
    case SEARCH_BACK:
      if ( resultCount-7 > 0 )
        resultCount = resultCount -7;
      return false;
    default:
      printData = false;
      return true;
    }
  }

  void resetSearch() {
    nextCount = 1;
    searchCount = 30;
  }
}

// ---------------- MAP ----------------
class MapScreen extends Screen {
  String formatString = "%s\nTotal Flights: %s (%.2f%%)\nDiverted: %s\nCancelled: %s\n";
  MapWidget map;
  Button backButton, closeInfoButton;
  TextWidget stateLabel, infoLabel;
  Widget info;
  PieChart pieChart;
  String currentState;
  float totalFlights;
  Boolean drag;
  String total, diverted, cancelled;

  MapScreen() {
    super();
    map = new MapWidget(25, 25, SCREENX-50, SCREENY-100, "usa-wikipedia.svg");
    map.setColor(color(0));

    totalFlights = (float) dataFile.getTotal();

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

    // pie chart on infobox
    float[] data = {1, 1, 1};
    color[] colors = {color(255, 0, 0), color(0, 255, 0), color(255, 255, 0)};
    pieChart = new PieChart(data, colors, 250, 350, 250);
    info.addChild(pieChart);





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
      int totalInt = dataFile.countTotalState(state);
      int divertedInt = dataFile.countDivertedState(state);
      int cancelledInt = dataFile.countCancelledState(state);
      float totalPercent = (float) totalInt / totalFlights;
      total = fancyNumber(totalInt);
      diverted = fancyNumber(divertedInt);
      cancelled = fancyNumber(cancelledInt);
      infoLabel.setLabel(String.format(formatString, map.getFullStateName(state), total, totalPercent*100, diverted, cancelled));
      pieChart.data[0] = cancelledInt;
      pieChart.data[1] = totalInt - (divertedInt + cancelledInt);
      pieChart.data[2] = divertedInt;
      pieChart.setup();
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
  PieChart thePieChart = new PieChart(flights,
    colors, 400, 300, 300);
  Button backButton = new Button(25, SCREENY-65, 80, 55);
  Button reset = new Button(120, SCREENY-65, 100, 55);


  OverviewScreen() {
    super();
    addWidget(backButton);
    addWidget(success);
    addWidget(divert);
    addWidget(cancel);
    addWidget(reset);
    success.setLabel("toggle successful ("+notCancelled+")");
    success.setLabelSize(24);
    success.setAlign(CENTER);
    success.setEvent(2);
    divert.setLabel("toggle diverted ("+diverted+")");
    divert.setLabelSize(24);
    divert.setAlign(CENTER);
    divert.setEvent(3);
    cancel.setLabel("toggle cancelled ("+cancelledFlights+")");
    cancel.setLabelSize(24);
    cancel.setAlign(CENTER);
    cancel.setEvent(1);
    backButton.setLabel("BACK");
    backButton.setAlign(CENTER);
    backButton.setLabelSize(24);
    backButton.moveLabel(0, -3);
    backButton.setEvent(GLOBAL_EVENT_MENU_SCREEN);
    reset.setLabel("RESET");
    reset.setAlign(CENTER);
    reset.setLabelSize(24);
    reset.moveLabel(0, -3);
    reset.setEvent(4);
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
      return false;
    case 2:
      if (flights[1]==0) flights[1]=notCancelled;
      else flights[1]=0;
      thePieChart.setup();
      return false;
    case 3:
      if (flights[2]==0) flights[2]=diverted;
      else flights[2]=0;
      thePieChart.setup();
      return false;
    case 4:
      flights[0]=cancelledFlights;
      flights[1]=notCancelled;
      flights[2]=diverted;
      thePieChart.setup();
      return false;
    }
  }
}
