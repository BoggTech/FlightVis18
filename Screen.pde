// Screen.pde // Author: Darryl

class Screen extends Widget {
  // screen is just a zero-width widget that only draws its children
  // this will allow us to do some funky animations later
  Screen() {
    setX(0);
    setY(0);
  }
  
  // the screen itself is merely just there for its origin point, so lets only draw the children (our widgets)
  void draw() {
    drawChildren();
  }
  
  // just an alias
  void addWidget(Widget widget) {
    addChild(widget);
  }
  
  // just an alias
  void removeWidget(Widget widget) {
    removeChild(widget);
  }

  boolean isTouching(int mouseX, int mouseY) {
    return true; // whole screen
    // may change this later
  }
  
  // screen getEvent is special
  // it will call a "handleEvent" method that may choose to handle the event within the current screen, or pass the id up
  // for global events. this naming conventions a little weird, but it only applies to screens and not widgets.
  // screens that extend this should override handleEvent for their own purposes.
  int getEvent(int mouseX, int mouseY) {
    for ( int i = 0; i < getChildrenLength(); i++ ) {
      Widget child = (Widget) getChild(i);
      if ( child.isTouching(mouseX, mouseY) && child.shown ) {
        int event = child.getEvent();
        if ( handleEvent(event) ) {
          return event;
        }
      }
    }
    return GLOBAL_EVENT_NULL;
  }
  
  // handleEvent: see above
  boolean handleEvent(int event) {
    // return true to pass the event up the chain; do things + return false to handle it within the screen
    return true;
  }
}
