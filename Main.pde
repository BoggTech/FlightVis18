Screen screen;

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  screen = new DebugScreen();
}

void draw() {
  background(100);
  screen.draw();
}

void mousePressed() {
  // for "global" events  not sure if this'll be needed (beyond screen transitions maybe?
  // global events are always negative; 0 is "null event"
  screen.mousePressed(mouseX, mouseY);
  int event = screen.getEvent(mouseX, mouseY);
  switch( event ) {
  case GLOBAL_EVENT_RIGHT:
    // just a test; shifts it forward to show the button works
    screen.setX(screen.getX()+50);
    break;
  case GLOBAL_EVENT_LEFT:
    screen.setX(screen.getX()-50);
    break;
  case GLOBAL_EVENT_NULL:
    break;
  }
}

void mouseDragged() {
  screen.mouseDragged(mouseX, mouseY, pmouseX, pmouseY);
}
