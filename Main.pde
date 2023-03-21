final int SCREENX = 600;
final int SCREENY = 600;

Screen screen;
Widget parent;
Widget widget2;

void settings() {
  size(SCREENX, SCREENY);
}

void setup() {
  screen = new Screen();
  
  parent = new Widget(SCREENX/2, SCREENY/2, 50, 50);
  widget2 = new Widget(20, 20, 50, 50, parent); // technically you don't even need to assign this to a var
  
  screen.addWidget(parent);
}

void draw() {
  screen.draw();
}
