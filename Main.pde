import geomerative.*;

Screen nextScreen, menuScreen, mapScreen, searchScreen, screen, screen2, screen3, overviewScreen, activeScreen;
DataFile dataFile;
boolean ready = false;
boolean printData = false;
boolean error = false;
boolean transition, left;
PShape gear, logo, warning;
String currentJob;
float loadCounter;
final int transitionSpeed = 50;

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  RG.init(this);
  RG.ignoreStyles(true);
  loadCounter = 0;
  currentJob = "";
  gear = loadShape("gear.svg");
  logo = loadShape("logothing.svg");
  gear.setFill(TEXT_COLOR);
  gear.disableStyle();
  logo.disableStyle();
  logo.setFill(TEXT_COLOR);
  transition = false;
  thread("setUpScreens");
}

void draw() {
  background(BG_COLOR);
  if ( !ready ) {
    loadingSpin();
    return;
  } else if ( transition ) {
    transitionDraw();
    return;
  }
  activeScreen.checkCollisions(mouseX, mouseY);
  activeScreen.draw();
}

void loadingSpin() {
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
}

void transitionDraw() {
  if ( !left ) {
      activeScreen.setX(activeScreen.getX()-transitionSpeed);
      nextScreen.setX(nextScreen.getX()-transitionSpeed);
      activeScreen.draw();
      nextScreen.draw();
      if ( nextScreen.getX()-transitionSpeed < 0 ) {
        transition = false;
        activeScreen.setX(0);
        nextScreen.setX(0);
        activeScreen = nextScreen;
        nextScreen = null;
      }
    } else {
      activeScreen.setX(activeScreen.getX()+transitionSpeed);
      nextScreen.setX(nextScreen.getX()+transitionSpeed);
      activeScreen.draw();
      nextScreen.draw();
      if ( nextScreen.getX()+transitionSpeed > 0 ) {
        transition = false;
        activeScreen.setX(0);
        nextScreen.setX(0);
        activeScreen = nextScreen;
        nextScreen = null;
      }
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
  case GLOBAL_EVENT_MENU_SCREEN:
    transition(menuScreen, LEFT);
    break;
  case GLOBAL_EVENT_MAP_SCREEN:
    transition(mapScreen, RIGHT);
    break;
  case GLOBAL_EVENT_SEARCH_SCREEN:
    transition(searchScreen, RIGHT);
    break;
  case GLOBAL_EVENT_OVERVIEW_SCREEN:
    transition(overviewScreen, RIGHT);
    break;
  case GLOBAL_EVENT_NULL:
    break;
  }
}

void transition(Screen screen, int direction) {
  if ( !transition ) {
    if ( direction == RIGHT ) {
      left = false;
      transition = true;
      nextScreen = screen;
      nextScreen.setX(SCREENX);
    } else {
      left = true;
      transition = true;
      nextScreen = screen;
      nextScreen.setX(-SCREENX);
    }
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

void mouseWheel(MouseEvent event) {
  if ( !ready ) {
    return;
  }
  activeScreen.mouseWheel(event.getCount());
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

  currentJob = "OverviewScreen";
  overviewScreen = new OverviewScreen();

  currentJob = "MapScreen";
  mapScreen = new MapScreen();

  currentJob = "nothing";
  activeScreen = menuScreen;
  ready = true;
}

static String fancyNumber(int number) {
  String totalFlightsString = Integer.toString(number);
  String newString = "";
  for ( int i = totalFlightsString.length(); i > 3; i -= 3 ) {
    String cut = totalFlightsString.substring(totalFlightsString.length()-3, totalFlightsString.length());
    totalFlightsString = totalFlightsString.substring(0, totalFlightsString.length()-3);
    newString =  "," + cut + newString;
  }
  newString = totalFlightsString + newString;
  return newString;
}
