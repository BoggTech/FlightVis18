// Main.pde

// Stock processing SVG functions have bugs w/
// scaling, we use geomerative to get past these.
import geomerative.*;

Screen nextScreen, menuScreen, mapScreen, searchScreen, screen, screen2, screen3, overviewScreen, activeScreen;
DataFile dataFile;
boolean ready = false;
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
  // we need to initalize geomerative
  RG.init(this);
  RG.ignoreStyles(true);

  // set up some SVGs + loading screen variables
  loadCounter = 0; // for counting frames spent loading
  currentJob = "";
  gear = loadShape("gear.svg");
  logo = loadShape("logothing.svg");
  warning = loadShape("warning.svg");
  warning.disableStyle();
  warning.setFill(TEXT_COLOR);
  gear.setFill(TEXT_COLOR);
  gear.disableStyle();
  logo.disableStyle();
  logo.setFill(TEXT_COLOR);

  // set to true when screen is moving left/right
  transition = false;

  // begin thread to load everything; will set ready to "true" when done
  thread("setUpScreens");
}

void draw() {
  background(BG_COLOR);
  // if we are drawing any of these, we don't want to continue on, so we return
  if ( !ready ) {
    loadingSpin();
    return;
  } else if ( transition ) {
    transitionDraw();
    return;
  }

  // checkCollisions for highlighting (my naming conventions are goofy)
  activeScreen.checkCollisions(mouseX, mouseY);
  activeScreen.draw();
}

void loadingSpin() {
  background(BG_COLOR);
  textSize(32);
  textAlign(CENTER, CENTER);
  textLeading(30);
  fill(TEXT_COLOR);

  // frames spent loading
  loadCounter++;
  // currentJob set by loading thread to signify what class is loading
  if ( !error ) {
    text("Loading " + currentJob + "..."
      + "\n" + round(loadCounter/60), SCREENX/2, SCREENY/2+96); // 60fps, time in seconds
    pushMatrix();
    noStroke();
    translate(SCREENX/2, SCREENY/2);
    rotate((((float) frameCount)/15));
    shape(gear, -50, -50, 100, 100);
    popMatrix();
    textAlign(LEFT);
  } else {
    shape(warning, SCREENX/2-50, SCREENY/2-50, 100, 100);
    text("SQL error! Please ensure flights.db is installed correctly.\nView \"README.md\" for more info.", SCREENX/2, SCREENY/2+96);
  }
}

void transitionDraw() {
  if ( !left ) {
    // move both screens right and draw them
    activeScreen.setX(activeScreen.getX()-transitionSpeed);
    nextScreen.setX(nextScreen.getX()-transitionSpeed);
    activeScreen.draw();
    nextScreen.draw();
    if ( nextScreen.getX()-transitionSpeed < 0 ) {
      // we're done; wrap it up
      transition = false;
      activeScreen.setX(0);
      nextScreen.setX(0);
      activeScreen = nextScreen;
      nextScreen = null;
    }
  } else {
    // move both screens left and draw them
    activeScreen.setX(activeScreen.getX()+transitionSpeed);
    nextScreen.setX(nextScreen.getX()+transitionSpeed);
    activeScreen.draw();
    nextScreen.draw();
    if ( nextScreen.getX()+transitionSpeed > 0 ) {
      // done; wrap up
      transition = false;
      activeScreen.setX(0);
      nextScreen.setX(0);
      activeScreen = nextScreen;
      nextScreen = null;
    }
  }
}

// function to initialize the transition process
void transition(Screen screen, int direction) {
  // make sure we can't stack transitions, bug
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

// ---------- INPUT FUNCTIONS -------------
// These functions are passed down each screen/widget/child
// each one can choose how to handle it by overriding their "on" functions
// or simply ignore it.

void mousePressed() {
  // we don't want to do anything if nothing is loaded
  if ( !ready ) {
    return;
  }

  // function will get passed down to each widget to be handled by "onMousePressed"
  // some screens/widgets will handle things differently, without the event system.
  activeScreen.mousePressed(mouseX, mouseY);

  // getEvent will only return event IDs that aren't handled within the screen
  // this mostly exists for events that cause screen transitions
  // getEvent can be misleading because it carries out the action from the events
  // when applied on a screen. My Bad :(
  int event = activeScreen.getEvent(mouseX, mouseY);
  switch( event ) {
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

void mouseDragged() {
  // we don't want to do anything if nothing is loaded
  if ( !ready ) {
    return;
  }
  activeScreen.mouseDragged(mouseX, mouseY, pmouseX, pmouseY);
}

void keyPressed() {
  // we don't want to do anything if nothing is loaded
  if ( !ready ) {
    return;
  }
  activeScreen.keyPressed(key);
}

void mouseWheel(MouseEvent event) {
  // we don't want to do anything if nothing is loaded
  if ( !ready ) {
    return;
  }
  activeScreen.mouseWheel(event.getCount());
}

void mouseReleased() {
  // we don't want to do anything if nothing is loaded
  if ( !ready ) {
    return;
  }
  activeScreen.mouseReleased(mouseX, mouseY);
}

void setUpScreens() {
  currentJob = "DataFile";
  dataFile = new DataFile(dataPath("flights.db"));
  if ( dataFile.getTotal() == -1 ) {
    error = true;
    return;
  }

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

// util function that will create formatted number strings
// e.g. (int) 8747384 => "8,747,384"
// Author: Darryl Boggins
static String fancyNumber(int number) {
  String numberString = Integer.toString(number);
  String newString = "";
  int digitCount = numberString.length();
  for ( int i = digitCount; i > 3; i -= 3 ) {
    digitCount = numberString.length();
    String cut = numberString.substring(digitCount-3, digitCount);
    numberString = numberString.substring(0, digitCount-3);
    newString =  "," + cut + newString;
  }
  newString = numberString + newString;
  return newString;
}
