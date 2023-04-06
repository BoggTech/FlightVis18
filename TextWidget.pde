class TextWidget extends Widget {
  String fontName;
  int fontSize;
  PFont WidgetFont;
  String text;
  boolean drawBackground;
  int align;

  TextWidget(int x, int y, int width, int height) {
    this("", "", 32, x, y, width, height, color(0));
    setColor(TEXT_COLOR);
  }
  
  TextWidget(String fontName, String text, int fontSize, float x, float y, float xSize, float ySize) {
    this(fontName, text, fontSize, x, y, xSize, ySize, color(0));
    setColor(TEXT_COLOR);
  }

  TextWidget(String fontName, String text, int fontSize, float x, float y, float xSize, float ySize, color textColor) {
    this.fontName = fontName;
    this.text = text;
    this.fontSize = fontSize;
    setX(x);
    setY(y);
    setWidth(xSize);
    setHeight(ySize);
    setColor(textColor);
    WidgetFont = createFont(fontName, fontSize);
    drawBackground = false;
    align = LEFT;

    addChild(new Widget(0, 0, getWidth(), getHeight()));
    getBackground().setSelectedBorderColor(color(0));
  }

  void setDrawBackground(boolean status) {
    drawBackground = status;
  }

  void setLabel(String text) {
    this.text = text;
  }
  
  void setTextSize(int size) {
    fontSize = size;
    WidgetFont = createFont(fontName, fontSize);
  }
  
  void setPosition(int x, int y) {
    setX(x);
    setY(y);
  }
  
  String getLabel() {
    return text;
  }

  Widget getBackground() {
    Widget background = (Widget) getChild(0);
    return background;
  }
  
  void setAlign(int align) {
    this.align = align;
  }

  void draw() {
    textAlign(align, align);
    if ( drawBackground ) {
      getBackground().draw();
    }
    textFont(WidgetFont);
    fill(getColor());
    text(text, getEffectiveX(), getEffectiveY(), getWidth(), getHeight());
  }
  
  void move(int x, int y) {
    setX(getX() + x);
    setY(getY() + y);
  }
}
