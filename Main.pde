import geomerative.*;

Screen menuScreen, mapScreen, searchScreen, screen, screen2, screen3, activeScreen;
DataFile dataFile;
SearchBar search;
String word = "";
boolean searchOn = false;
boolean ready = false;
boolean printData = false;
PShape gear, logo;
String currentJob;
float loadCounter;
String dataAsString = "";
ArrayList<FlightObject> modifiedObjects = new ArrayList<>();

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  RG.init(this);
  loadCounter = 0;
  currentJob = "";
  search = new SearchBar();
  gear = loadShape("gear.svg");
  logo = loadShape("logothing.svg");
  gear.setFill(TEXT_COLOR);
  gear.disableStyle();
  logo.disableStyle();
  logo.setFill(TEXT_COLOR);
  thread("setUpScreens");
}

void draw() {
  if ( !ready ) {
    background(BG_COLOR);
    textSize(32);
    textAlign(CENTER, CENTER);
    loadCounter++;
    textLeading(30);
    fill(TEXT_COLOR);
    text("Loading " + currentJob + "..."
      + "\n" + round(loadCounter/60), SCREENX/2, SCREENY/2+96);
    pushMatrix();
    noStroke();
    translate(SCREENX/2, SCREENY/2);
    rotate((((float) frameCount)/15));
    shape(gear, -50, -50, 100, 100);
    popMatrix();
    textAlign(LEFT);
    return;
  }
  background(BG_COLOR);
  activeScreen.checkCollisions(mouseX, mouseY);
  activeScreen.draw();
  if(searchOn == true){
    fill(255);
    search.draw();
  }
  else{
    fill(TEXT_COLOR);
    textSize(17);
    text(dataAsString , 450, 125);
  }
}

void mousePressed() {
  if ( !ready ) {
    return;
  }
  // for "global" events  not sure if this'll be needed (beyond screen transitions maybe?
  // global events are always negative; 0 is "null event"
  activeScreen.mousePressed(mouseX, mouseY);
  int event = activeScreen.getEvent(mouseX, mouseY);
  switch( event ) {
  case GLOBAL_EVENT_RIGHT:
    // just a test; shifts it forward to show the button works
    activeScreen.setX(screen.getX()+50);
    break;
  case GLOBAL_EVENT_LEFT:
    activeScreen.setX(screen.getX()-50);
    break;
  case GLOBAL_EVENT_DEBUG_1:
    activeScreen = screen;
    break;
  case GLOBAL_EVENT_DEBUG_2:
    activeScreen = screen2;
    break;
  case GLOBAL_EVENT_DEBUG_3:
    activeScreen = screen3;
    break;
  case GLOBAL_EVENT_MAP_SCREEN:
    activeScreen = mapScreen;
    break;
  case GLOBAL_EVENT_SEARCH_SCREEN:
    activeScreen = searchScreen;
    break;
  case SEARCH_EVENT_2:
    activeScreen = searchScreen;
    break;
  case SEARCH_EVENT_7:
    activeScreen = searchScreen;
    print(search.getResult());
    
  case GLOBAL_EVENT_NULL:
    break;
  }
}

void mouseDragged() {
  if ( !ready ) {
    return;
  }
  activeScreen.mouseDragged(mouseX, mouseY, pmouseX, pmouseY);
}

void keyPressed() {
  if ( !ready ) {
    return;
  }
  activeScreen.keyPressed(key);
}

void mouseReleased() {
  if ( !ready ) {
    return;
  }
  activeScreen.mouseReleased(mouseX, mouseY);
}

void setUpScreens() {
  currentJob = "DataFile";
  dataFile = new DataFile(dataPath("flights.db"));

  currentJob = "MenuScreen";
  menuScreen = new MenuScreen();

  currentJob = "SearchScreen";
  searchScreen = new SearchScreen();

  currentJob = "MapScreen";
  mapScreen = new MapScreen();

  currentJob = "nothing";
  activeScreen = menuScreen;
  ready = true;
}
