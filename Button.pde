class Button extends Widget {  
  Button() {
    this(0, 0, 0, 0, color(0), null);
  }
  
  Button(float x, float y, float width, float height) {
    this(x, y, width, height, color(128), null);
  }
  
  Button(float x, float y, float width, float height, Widget parent) {
    this(x, y, width, height, color(128), parent);
  }

  Button(float x, float y, float width, float height, color widgetColor) {
    this(x, y, width, height, widgetColor, null);
  }

  Button(float x, float y, float width, float height, color widgetColor, Widget parent) {
    super(x, y, width, height, widgetColor, parent);
  }
  
  /*void onClick() {
    setColor(color(random(0,255)));
  }*/
}
