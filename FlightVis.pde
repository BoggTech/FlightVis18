// temporarily commenting this out; conflicts with main

/*
Screen screen;
SearchBar search;
DataReader data;
String dataAsString = "";
Boolean searchOn = false;
ArrayList<FlightObject> modifiedObjects = new ArrayList<>();

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  screen = new SearchScreen();
  search = new SearchBar();
  data = new DataReader();
  data.read_in_the_file();
}

void draw() {
  background(100);
  screen.draw();
  fill(255);
  text("Date", 20, 50);
  text("Origin", 20, 125);
  text("Dest", 20, 200);
  text("ArrTime", 20, 275);
  text("DepTime", 20, 350);
  
  if(searchOn == true){
    fill(255);
    text(search.textValue, 155, 50);
    search.draw();
  }
  else{
    fill(255);
    text("Search ", 155, 50);
    textSize(17);
    text(dataAsString , 155, 100);
  }
  
}

void mousePressed() {
  // for "global" events  not sure if this'll be needed (beyond screen transitions maybe?
  // global events are always negative; 0 is "null event"
  screen.mousePressed(mouseX, mouseY);
  int event = screen.getEvent(mouseX, mouseY);
  switch( event ) {
  case SEARCH_EVENT_1:
    // just a test; shifts it forward to show the button works
    //screen.setX(screen.getX()+50);
    searchOn = true;
    break;
  case SEARCH_EVENT_2:
    searchOn = false;
    break;
  case SEARCH_EVENT_3:
   dataAsString = "";
   for(int i = 0; i < flightObjects.size(); i++){
     
      String flightDate1 = flightObjects.get(i).getFlightDate();
      String[] flightDate2 = flightDate1.split("/");
      String flightDate = flightDate2[1];
      String word = search.textValue;
      
      if(flightDate.equalsIgnoreCase(word)){
        dataAsString = dataAsString +("Flight Number : " + flightObjects.get(i).getFlightNumber() + ", " + flightObjects.get(i).getFlightDate()  + " - " + flightObjects.get(i).getDepTime() + "\n");
      }
      
    }
    searchOn = false;
    break;
  case SEARCH_EVENT_4:
    dataAsString = "";
    for(int i = 0; i < flightObjects.size(); i++){
      
      String flightOrigin = flightObjects.get(i).getOriginState();
      String word = search.textValue;
      
      if(flightOrigin.equalsIgnoreCase(word)){
        dataAsString = dataAsString +("Flight Number : " + flightObjects.get(i).getFlightNumber() + ", " + flightObjects.get(i).getOriginCity()  + " - " + flightObjects.get(i).getDestCity()+ "\n");
      }
      
    }
    searchOn = false;
    break;
  case SEARCH_EVENT_5:
   dataAsString = "";
   for(int i = 0; i < flightObjects.size(); i++){
     
      String flightDest = flightObjects.get(i).getDestState();
      String word = search.textValue;
      
      if(flightDest.equalsIgnoreCase(word)){
        dataAsString = dataAsString +("Flight Number : " + flightObjects.get(i).getFlightNumber() + ", " + flightObjects.get(i).getOriginCity()  + " - " + flightObjects.get(i).getDestCity()+ "\n");
      }
      
    }
    
    searchOn = false;
    break;
  case SEARCH_EVENT_6:
   dataAsString = "";
   for(int i = 0; i < flightObjects.size(); i++){
      
      String flightArrTime = String.valueOf(flightObjects.get(i).getArrTime());
      String word = search.textValue;
      
      if(flightArrTime.equalsIgnoreCase(word)){
        dataAsString = dataAsString +("Flight Number : " + flightObjects.get(i).getFlightNumber() + ", " + flightObjects.get(i).getArrTime()  + " - " + flightObjects.get(i).getDepTime()+ "\n");
      }
      
    }
    searchOn = false;
    break;
  case SEARCH_EVENT_7:
     dataAsString = "";
     for(int i = 0; i < flightObjects.size(); i++){
      
      String flightDepTime = String.valueOf(flightObjects.get(i).getDepTime());
      String word = search.textValue;
      
      if(flightDepTime.equalsIgnoreCase(word)){
        dataAsString = dataAsString +("Flight Number : " + flightObjects.get(i).getFlightNumber() + ", " + flightObjects.get(i).getArrTime()  + " - " + flightObjects.get(i).getDepTime()+ "\n");
      }
      
    }
    searchOn = false;
    break;
  case GLOBAL_EVENT_NULL:
    break;
  }
}

void mouseDragged() {
  screen.mouseDragged(mouseX, mouseY, pmouseX, pmouseY);
}*/
