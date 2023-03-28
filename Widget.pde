class Widget {
  // class for a basic widget square
  // will move with its parent
  // TODO: may rename effectiveX to be the x position, and turn how X is currently into relative x?
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
  private int event;

  Widget() {
    this(0, 0, 0, 0, color(0), null);
  }

  Widget(float x, float y, float width, float height) {
    this(x, y, width, height, color(128), null);
  }

  Widget(float x, float y, float width, float height, Widget parent) {
    this(x, y, width, height, color(128), parent);
  }

  Widget(float x, float y, float width, float height, color widgetColor) {
    this(x, y, width, height, widgetColor, null);
  }

  Widget(float x, float y, float width, float height, color widgetColor, Widget parent) {
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

  void setDefaultBorderColor(color borderColor) {
    defaultBorderColor = borderColor;
  }

  void setSelectedBorderColor(color borderColor) {
    selectedBorderColor = borderColor;
  }

  void setBorderColor(color borderColor) {
    this.borderColor = borderColor;
  }

  Widget getParent() {
    return parent;
  }

  ArrayList<Widget> getChildren() {
    ArrayList<Widget> copy = (ArrayList) children.clone();
    return copy;
  }

  int getChildrenLength() {
    return children.size();
  }

  Object getChild(int id) {
    if ( id >= 0 && id < children.size() ) {
      return (Widget) children.get(id);
    } else {
      return null;
    }
  }

  int getId() {
    return id;
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

  float getRotation() {
    return rotation;
  }

  void setRotation(float rotation) {
    this.rotation = rotation;
  }

  void setColor(color widgetColor) {
    this.widgetColor = widgetColor;
  }

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

  void removeParent() {
    setParent(null);
  }

  boolean removeChild(Widget child) {
    if ( children.get(child.getId()) != child ) {
      // i don't own you
      return false;
    } else {
      int removeId = child.getId();
      children.remove(removeId);
      for ( int i = removeId; i < children.size(); i++ ) {
        Widget widget = (Widget) children.get(i);
        widget.setId(i);
      }
      child.removeParent();
      return true;
    }
  }

  boolean isTouching(int mouseX, int mouseY) {
    if ( mouseX>effectiveX && mouseX < effectiveX+width
      && mouseY >effectiveY && mouseY <effectiveY+height )
      return true;
    return false;
  }

  void mouseTouching() {
    borderColor = selectedBorderColor;
    checkCollisions(mouseX, mouseY);
  }

  void mousePressed(int mouseX, int mouseY) {
    onClick();
    for ( int i = 0; i < getChildrenLength(); i++ ) {
      Widget widget = (Widget) getChild(i);
      if ( widget.isTouching(mouseX, mouseY) ) {
        widget.mousePressed(mouseX, mouseY);
      }
    }
  }

  void onClick() {
    // boring
  }

  void mouseDragged(int mouseX, int mouseY, int pmouseX, int pmouseY) {
    onDrag(mouseX, mouseY, pmouseX, pmouseY);
    for ( int i = 0; i < getChildrenLength(); i++ ) {
      Widget widget = (Widget) getChild(i);
      if ( widget.isTouching(mouseX, mouseY) ) {
        widget.mouseDragged(mouseX, mouseY, pmouseX, pmouseY);
      }
    }
  }

  void onDrag(int mouseX, int mouseY, int pmouseX, int pmouseY) {
    // boring
  }

  void mouseReleased() {
    onMouseReleased();
    for ( int i = 0; i < getChildrenLength(); i++ ) {
      Widget widget = (Widget) getChild(i);
      widget.mouseReleased();
    }
  }

  void onMouseReleased() {
  }

  void draw() {
    fill(widgetColor);
    pushMatrix();
    translate(effectiveX+width/2, effectiveY+height/2);
    rotate(rotation);
    stroke(borderColor);
    rect(-width/2, -height/2, width, height);
    popMatrix();
    borderColor = defaultBorderColor;
    drawChildren();
  }

  void drawChildren() {
    for ( int i = 0; i < children.size(); i++ ) {
      Widget widget = (Widget) children.get(i);
      widget.draw();
    }
  }

  void checkCollisions(int mouseX, int mouseY) {
    for ( int i = 0; i < getChildrenLength(); i++ ) {
      Widget widget = (Widget) getChild(i);
      if ( widget.isTouching(mouseX, mouseY) ) {
        widget.mouseTouching();
      }
    }
  }

  void setEvent(int event) {
    this.event = event;
  }

  int getEvent(int mouseX, int mouseY) {
    for ( int i = 0; i < getChildrenLength(); i++ ) {
      Widget child = (Widget) getChild(i);
      if ( child.isTouching(mouseX, mouseY) ) {
        int event = child.getEvent();
        if ( handleEvent(event) ) {
          return event;
        }
      }
      return this.getEvent();
    }
    return GLOBAL_EVENT_NULL;
  }
}
