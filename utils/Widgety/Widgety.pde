ArrayList widgets;
boolean down;
Widget currentWidget;
int lockedX;
int lockedY;

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  widgets = new ArrayList<>();
  down = false;
  currentWidget = null;
  lockedX = 0;
  lockedY = 0;
}

void draw() {
  background(255);
  if ( down && currentWidget != null ) {
    currentWidget.setWidth(mouseX-lockedX);
    currentWidget.setHeight(mouseY-lockedY);
  }
  
  for ( int i = 0; i < widgets.size(); i++ ) {
    Widget widget = (Widget) widgets.get(i);
    widget.draw();
  }
}

void mousePressed() {
  println(down);
  if ( !down ) {
    lockedX = mouseX;
    lockedY = mouseY;
    down = true;
    currentWidget = new Widget(mouseX, mouseY, 0, 0);
    widgets.add(currentWidget);
  }
}

void mouseReleased() {
  if ( down ) {
    down = false;
    currentWidget = null;
  }
}
