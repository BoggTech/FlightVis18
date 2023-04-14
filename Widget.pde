// Widget // Author: Darryl

class Widget {
  // class for a basic widget square
  // will move with its parent
  // TODO: may rename effectiveX to be the x position, and turn how X is currently into relative x? confusing naming convention
  private float x;
  private float y;
  private float originX;
  private float originY;
  private float effectiveX;
  private float effectiveY;
  private float width;
  private float height;
  private color widgetColor;
  private color borderColor;
  private color defaultBorderColor;
  private color selectedBorderColor;
  private Widget parent;
  private ArrayList children;
  private int id;
  private float rotation;
  private boolean shown;
  private int event;

  Widget() {
    this(0, 0, 0, 0, color(BG_COLOR), null);
  }

  Widget(float x, float y, float width, float height) {
    this(x, y, width, height, color(BG_COLOR), null);
  }

  Widget(float x, float y, float width, float height, Widget parent) {
    this(x, y, width, height, color(BG_COLOR), parent);
  }

  Widget(float x, float y, float width, float height, color widgetColor) {
    this(x, y, width, height, widgetColor, null);
  }

  Widget(float x, float y, float width, float height, color widgetColor, Widget parent) {
    shown = true;
    children = new ArrayList<>();
    this.x = x;
    this.y = y;
    setParent(parent);
    setWidth(width);
    setHeight(height);
    setColor(widgetColor);
    updatePosition();
    rotation = 0;

    borderColor = color(0);
    selectedBorderColor = color(255);
    defaultBorderColor = color(0);
  }
  
  // when setting X/Y, we want to make sure the widget is using its parent's X/Y position as its
  // origin, rather than 0,0. we do that here.
  private void updatePosition() {
    if ( parent != null ) {
      originX = parent.getEffectiveX();
      originY = parent.getEffectiveY();
    } else {
      originX = 0;
      originY = 0;
    }
    effectiveX = originX + x;
    effectiveY = originY + y;
    for ( int i = 0; i < children.size(); i++ ) {
      Widget widget = (Widget) children.get(i);
      widget.updatePosition();
    }
  }
  
  // methods for showing/hiding the widget. will not render if set to false.
  void show() {
    shown = true;
  }
  
  void hide() {
    shown = false;
  }

  // getters
  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  float getEffectiveX() {
    return effectiveX;
  }

  float getEffectiveY() {
    return effectiveY;
  }

  float getWidth() {
    return width;
  }

  float getHeight() {
    return height;
  }

  color getColor() {
    return widgetColor;
  }
  
  color getDefaultBorderColor() {
    return defaultBorderColor;
  }

  color getSelectedBorderColor() {
    return selectedBorderColor;
  }

  color getBorderColor() {
    return borderColor;
  }
  
  ArrayList<Widget> getChildren() {
    ArrayList<Widget> copy = (ArrayList) children.clone();
    return copy;
  }
  
  Widget getParent() {
    return parent;
  }

  Object getChild(int id) {
    if ( id >= 0 && id < children.size() ) {
      return (Widget) children.get(id);
    } else {
      return null;
    }
  }

  int getChildrenLength() {
    return children.size();
  }
  
  // id is used by the parenting system; basically the widget's index in the list of children
  int getId() {
    return id;
  }
  
  // rotation is currently not implemented very well
  float getRotation() {
    return rotation;
  }
  
  int getEvent() {
    return event;
  }
  
  // setters
  void setDefaultBorderColor(color borderColor) {
    defaultBorderColor = borderColor;
  }

  void setSelectedBorderColor(color borderColor) {
    selectedBorderColor = borderColor;
  }

  void setBorderColor(color borderColor) {
    this.borderColor = borderColor;
  }

  void setX(float x) {
    this.x = x;
    updatePosition();
  }

  void setY(float y) {
    this.y = y;
    updatePosition();
  }

  void setWidth(float width) {
    this.width = width;
  }

  void setHeight(float height) {
    this.height = height;
  }

  void setRotation(float rotation) {
    this.rotation = rotation;
  }

  void setColor(color widgetColor) {
    this.widgetColor = widgetColor;
  }
  
  void setEvent(int event) {
    this.event = event;
  }

  // sets the parent of this widget to another; handles cleaning up
  void setParent(Widget parent) {
    if ( this.parent == parent || parent == this ) {
      // no need / very not good.. cant own yourself
      return;
    } else {
      // if this returns false, for whatever reason, we'll overwrite anyway.
      if ( this.parent != null ) {
        this.parent.removeChild(this);
      }
      if ( parent != null ) {
        parent.addChild(this);
      }
      this.parent = parent;
      updatePosition();
    }
  }

  private void setId(int id) {
    this.id = id;
  }

  // adds a child to list of child widgets; handles replacing parent, etc
  void addChild(Widget child) {
    if ( children.size() > child.getId() && children.get(child.getId()) == child || child == this ) {
      // don't need to / invalid, bad!!!
      return;
    } else {
      int newIndex = children.size();
      children.add(child);
      child.setId(newIndex);
      child.setParent(this);
    }
  }
  
  // removing parent/children
  void removeParent() {
    setParent(null);
  }

  boolean removeChild(Widget child) {
    if ( child.getId() >= children.size() || children.get(child.getId()) != child ) {
      // i don't own you
      return false;
    } else {
      int removeId = child.getId();
      children.remove(removeId);
      for ( int i = removeId-1; i < children.size(); i++ ) {
        Widget widget = (Widget) children.get(i);
        widget.setId(i);
      }
      child.removeParent();
      child.setId(0);
      return true;
    }
  }
  
  // collisions
  boolean isTouching(int mouseX, int mouseY) {
    if ( mouseX>effectiveX && mouseX < effectiveX+width
      && mouseY >effectiveY && mouseY <effectiveY+height )
      return true;
    return false;
  }
  
  // called by checkCollisions to a child when mouse is touching it, which will then call it again to check its own children.
  void mouseTouching() {
    borderColor = selectedBorderColor;
    checkCollisions(mouseX, mouseY);
  }
  
  // communicates that the mouse has been pressed to all children
  void mousePressed(int mouseX, int mouseY) {
    onClick(mouseX, mouseY);
    for ( int i = 0; i < getChildrenLength(); i++ ) {
      Widget widget = (Widget) getChild(i);
      widget.mousePressed(mouseX, mouseY);
    }
  }

  void onClick(int mouseX, int mouseY) {
    // called by mousePressed
  }
  
  // communicates that the mouse has been dragged to all children
  void mouseDragged(int mouseX, int mouseY, int pmouseX, int pmouseY) {
    onMouseDragged(mouseX, mouseY, pmouseX, pmouseY);
    for ( int i = 0; i < getChildrenLength(); i++ ) {
      Widget widget = (Widget) getChild(i);
      widget.mouseDragged(mouseX, mouseY, pmouseX, pmouseY);
    }
  }

  void onMouseDragged(int mouseX, int mouseY, int pmouseX, int pmouseY) {
    // called by mouseDragged
  }

  // communicates that the mouse has been released to all children
  void mouseReleased(int mouseX, int mouseY) {
    onMouseReleased(mouseX, mouseY);
    for ( int i = 0; i < getChildrenLength(); i++ ) {
      Widget widget = (Widget) getChild(i);
      widget.mouseReleased(mouseX, mouseY);
    }
  }

  void onMouseReleased(int mouseX, int mouseY) {
    // called by mouseReleased
  }

  // communicates that the mousewheel has been moved to all children
  void mouseWheel(int wheel) {
    onMouseWheel(wheel);
    for ( int i = 0; i < getChildrenLength(); i++ ) {
      Widget widget = (Widget) getChild(i);
      widget.mouseWheel(wheel);
    }
  }

  void onMouseWheel(int wheel) {
    // called by mouseWheel
  }
  
  // communicates that the keyboard has been pressed to all children
  void keyPressed(char keyValue) {
    onKeyPressed(keyValue);
    for ( int i = 0; i < getChildrenLength(); i++ ) {
      Widget widget = (Widget) getChild(i);
      widget.keyPressed(keyValue);
    }
  }

  void onKeyPressed(char keyValue) {
    // called by keyPressed
  }

  // draw me w/o children
  void drawThis() {
    if ( !shown ) {
      return;
    }
    fill(widgetColor);
    pushMatrix();
    translate(effectiveX+width/2, effectiveY+height/2);
    rotate(rotation);
    stroke(borderColor);
    rect(-width/2, -height/2, width, height);
    popMatrix();
    borderColor = defaultBorderColor;
  }
  
  // draw me + children
  void draw() {
    drawThis();
    drawChildren();
  }
  
  // draw only children
  // orphans......
  void drawChildren() {
    if ( !shown ) {
      return;
    }
    for ( int i = 0; i < children.size(); i++ ) {
      Widget widget = (Widget) children.get(i);
      widget.draw();
    }
  }
  
  // check collisions will check a child's collisions and then communicate to it that it is touching the mouse
  // this will then get called by the child through mouseTouching
  void checkCollisions(int mouseX, int mouseY) {
    for ( int i = 0; i < getChildrenLength(); i++ ) {
      Widget widget = (Widget) getChild(i);
      if ( widget.isTouching(mouseX, mouseY) ) {
        widget.mouseTouching();
      }
    }
  }
}
