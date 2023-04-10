class Slider extends Widget {
  private float progress;
  private final float margin = 5;
  private boolean pressed;

  Slider() {
    this(0, 0, 0, 0, color(0), null);
  }

  Slider(float x, float y, float width, float height) {
    this(x, y, width, height, color(128), null);
  }

  Slider(float x, float y, float width, float height, Widget parent) {
    this(x, y, width, height, color(128), parent);
  }

  Slider(float x, float y, float width, float height, color widgetColor) {
    this(x, y, width, height, widgetColor, null);
  }

  Slider(float x, float y, float width, float height, color widgetColor, Widget parent) {
    super(x, y, width, height, widgetColor, parent);
    progress = 0;
    addChild(new Widget(margin, margin, height-10, height-10, widgetColor, this));
    setSelectedBorderColor(color(0));
    pressed = false;
  }

  float getProgress() {
    return progress;
  }

  Widget getDragger() {
    return (Widget) getChild(0);
  }

  void onDrag(int mouseX, int mouseY, int pmouseX, int pmouseY) {
    Widget dragger = getDragger();
    float draggerWidth = dragger.getWidth();
    int distance = mouseX - int(getEffectiveX()); // relative X position of mouse
    float leftBound = margin+dragger.getWidth()/2; // max x positions on either side
    float rightBound = getWidth()-leftBound;

    if ( pressed ) {
      if ( distance < leftBound ) {
        dragger.setX(leftBound - draggerWidth/2);
      } else if ( distance > rightBound ) {
        dragger.setX(rightBound - draggerWidth/2);
      } else {
        dragger.setX(distance - draggerWidth/2);
      }
      float trackWidth = getWidth() - margin*2 - draggerWidth;
      progress = (getDragger().getX()-margin) / trackWidth;
    }
  }

  void onClick(int mouseX, int mouseY) {
    Widget dragger = getDragger();
    if ( dragger.isTouching(mouseX, mouseY) ) {
      pressed = true;
    }
  }

  void onMouseReleased(int mouseX, int mouseY) {
    pressed = false;
  }
  
  void draw() {
    Widget dragger = getDragger();
    if ( pressed ) {
      dragger.setBorderColor(dragger.getSelectedBorderColor());
    }
    super.draw();
  }
  
  
  void setProgress(float progress) {
    if ( progress >= 0 && progress <= 1 ) {
      this.progress = progress;
    }
  }
}
