
Screen screen;
SearchBar search;
DataReader data;
Boolean searchOn = false;
int heightOFWid ;
int lengthOfWid;
ArrayList<FlightObject> modifiedObjects = new ArrayList<>();

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  //flightObject = new FlightObject();
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
    for(int i =0; i < modifiedObjects.size(); i++){
      int flightsNo =  (int) Math.round(modifiedObjects.get(i).getFlightNumber());
      fill(255);
      text(flightsNo, 200, 200);
    }
  }
  else{
    fill(255);
    text("Search ", 155, 50);
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
    print(search.textValue);
    searchOn = false;
    break;
  case SEARCH_EVENT_3:
    //print(modifiedObject);
    searchOn = false;
    break;
  case SEARCH_EVENT_4:
    for(int i = 0; i < flightObjects.size(); i++){
      String flightOrigin = flightObjects.get(i).getOriginState();
      String word = search.textValue;
      
      if(flightOrigin.equalsIgnoreCase(word)){
        modifiedObjects.add(flightObjects.get(i));
        //print(flightObjects.get(i).getOriginCity());
      }
      
    }
    searchOn = false;
    break;
  case SEARCH_EVENT_5:
   for(int i = 0; i < flightObjects.size(); i++){
      String flightOrigin = flightObjects.get(i).getDestState();
      String word = search.textValue;
      
      if(flightOrigin.equalsIgnoreCase(word)){
        modifiedObjects.add(flightObjects.get(i));
        //print(flightObjects.get(i).getDestCity());
      }
      
    }
    
    searchOn = false;
    break;
  case SEARCH_EVENT_6:
    
    searchOn = false;
    break;
  case SEARCH_EVENT_7:
    
    searchOn = false;
    break;
  case GLOBAL_EVENT_NULL:
    break;
  }
}

void mouseDragged() {
  screen.mouseDragged(mouseX, mouseY, pmouseX, pmouseY);
}
