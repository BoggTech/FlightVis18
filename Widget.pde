class Widget {
  // class for a basic widget square
  // will move with its parent,
  private float x;
  private float y;
  private float originX;
  private float originY;
  private float effectiveX;
  private float effectiveY;
  private float width;
  private float height;
  private color widgetColor;
  private Widget parent;
  private ArrayList<Widget> children;
  private int id;
  private float rotation;

  Widget() {
    this(0, 0, 0, 0, color(0), null);
  }

  Widget(float x, float y, float width, float height, color widgetColor) {
    this(x, y, width, height, widgetColor, null);
  }

  Widget(float x, float y, float width, float height, color widgetColor, Widget parent) {
    children = new ArrayList<Widget>();
    this.x = x;
    this.y = y;
    setParent(parent);
    setWidth(width);
    setHeight(height);
    setColor(widgetColor);
    updatePosition();
    rotation = 0;
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
      children.get(i).updatePosition();
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

  Widget getParent() {
    return parent;
  }

  ArrayList<Widget> getChildren() {
    ArrayList<Widget> copy = (ArrayList) children.clone();
    return copy;
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
      if ( parent != null ) {
        // if this returns false, for whatever reason, we'll overwrite anyway.
        if ( this.parent != null ) {
          this.parent.removeChild(this);
        }
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
        children.get(i).setId(i);
      }
      child.removeParent();
      return true;
    }
  }

  boolean isTouching(int mouseX, int mouseY) {
    if ( mouseX>x && mouseX < x+width
      && mouseY >y && mouseY <y+height )
      return true;
    return false;
  }

  void onHover() {
  }

  void onClick() {
  }

  void onDrag() {
  }

  void draw() {
    fill(widgetColor);
    pushMatrix();
    translate(effectiveX+width/2, effectiveY+height/2);
    rotate(rotation);
    rect(-width/2, -height/2, width, height);
    popMatrix();
    drawChildren();
  }

  void drawChildren() {
    for ( int i = 0; i < children.size(); i++ ) {
      Widget widget = (Widget) children.get(i);
      widget.draw();
    }
  }
}
