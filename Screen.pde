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
}
