Screen screen, screen2, screen3, activeScreen;
DataFile dataFile;
boolean ready = false;
PShape gear;
String currentJob;
float loadCounter;

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  loadCounter = 0;
  currentJob = "";
  gear = loadShape("gear.svg");
  thread("setUpScreens");
}

void draw() {
  if ( !ready ) {
    background(128);
    fill(0);
    textSize(32);
    textAlign(CENTER, CENTER);
    loadCounter++;
    textLeading(30);
    text("Loading " + currentJob + "..."
      + "\n" + round(loadCounter/60), SCREENX/2, SCREENY/2+96);
    pushMatrix();
    translate(SCREENX/2, SCREENY/2);
    rotate((((float) frameCount)/15));
    shape(gear, -50, -50, 100, 100);
    popMatrix();
    textAlign(LEFT);
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

void mouseReleased() {
  activeScreen.mouseReleased(mouseX, mouseY);
}

void setUpScreens() {
  currentJob = "DataFile";
  dataFile = new DataFile(dataPath("flights.db"));

  currentJob = "DebugScreen";
  screen = new DebugScreen();

  currentJob = "DebugScreen2";
  screen2 = new DebugScreen2();

  currentJob = "SearchScreen";
  screen3 = new SearchScreen();

  currentJob = "nothing";
  activeScreen = screen;
  ready = true;
}
