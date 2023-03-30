Screen screen, screen2, screen3, activeScreen;
DataFile dataFile;
boolean ready = false;
PShape gear;

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  gear = loadShape("gear.svg");
  thread("setUpScreens");
}

void draw() {
  if ( !ready ) {
    background(128);
    pushMatrix();
    fill(0);
    translate(SCREENX/2, SCREENY/2);
    rotate((((float) frameCount)/15));
    shape(gear, -50, -50, 100, 100);
    popMatrix();
    return;
  }
  background(100);
  activeScreen.checkCollisions(mouseX, mouseY);
  activeScreen.draw();
}

void mousePressed() {
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
  case GLOBAL_EVENT_NULL:
    break;
  }
}

void mouseDragged() {
  activeScreen.mouseDragged(mouseX, mouseY, pmouseX, pmouseY);
}

void keyPressed() {
  activeScreen.keyPressed(key);
}

void setUpScreens() {
  dataFile = new DataFile(dataPath("flights.db"));
  screen = new DebugScreen();
  screen2 = new DebugScreen2();
  screen3 = new SearchScreen();
  activeScreen = screen;
  ready = true;
}
