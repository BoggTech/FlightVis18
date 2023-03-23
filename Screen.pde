class Screen extends Widget {
  // screen is just a zero-width widget that only draws its children
  // this will allow us to do some funky animations later
  Screen() {
    setX(0);
    setY(0);
  }

  void draw() {
    drawChildren();
  }

  void addWidget(Widget widget) {
    addChild(widget);
  }

  void removeWidget(Widget widget) {
    // just a reskin of removeChild
    removeChild(widget);
  }

  boolean isTouching(int mouseX, int mouseY) {
    return true; // whole screen
    // may change this later
  }

  int getEvent(int mouseX, int mouseY) {
    for ( int i = 0; i < getChildrenLength(); i++ ) {
      Widget child = (Widget) getChild(i);
      if ( child.isTouching(mouseX, mouseY) ) {
        return child.getEvent();
      }
    }
    return -1;
  }
}
