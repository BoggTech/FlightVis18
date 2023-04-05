import geomerative.*;

Screen menuScreen, mapScreen, searchScreen, screen, screen2, screen3, activeScreen;
DataFile dataFile;
boolean ready = false;
boolean error = false;
PShape gear, logo, warning;
String currentJob;
float loadCounter;

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  RG.init(this);
  RG.ignoreStyles=true;
  loadCounter = 0;
  currentJob = "";
  gear = loadShape("gear.svg");
  logo = loadShape("logothing.svg");
  warning = loadShape("warning.svg");
  gear.setFill(TEXT_COLOR);
  gear.disableStyle();
  logo.disableStyle();
  warning.disableStyle();
  logo.setFill(TEXT_COLOR);
  thread("setUpScreens");
}

void draw() {
  if ( !ready ) {
    loadingScreen();
    return;
  }
  background(BG_COLOR);
  activeScreen.checkCollisions(mouseX, mouseY);
  activeScreen.draw();
  textSize(16);
  text("[fps] remove in final\n" +frameRate, 0, 15);
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

void loadingScreen() {
  background(BG_COLOR);
  textSize(32);
  textAlign(CENTER, CENTER);
  loadCounter++;
  textLeading(30);
  fill(TEXT_COLOR);
  if ( error ) {
    shape(warning, SCREENX/2-50, SCREENY/2-50, 100, 100);
    text("Database error. Please check console.\n"
      +"Is \"flights.db\" installed correctly?", SCREENX/2, SCREENY/2+96);
  } else {
    text("Loading " + currentJob + "..."
      + "\n" + round(loadCounter/60), SCREENX/2, SCREENY/2+96);
    pushMatrix();
    noStroke();
    translate(SCREENX/2, SCREENY/2);
    rotate((((float) frameCount)/15));
    shape(gear, -50, -50, 100, 100);
    popMatrix();
  }
  textAlign(LEFT);
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

  currentJob = "MapScreen";
  mapScreen = new MapScreen();

  currentJob = "nothing";
  activeScreen = menuScreen;

  ready = true;
}
