class TextWidget extends Widget {
  String fontName;
  int fontSize;
  PFont WidgetFont;
  String text;
  boolean drawBackground;

  TextWidget(String fontName, String text, int fontSize, float x, float y, float xSize, float ySize) {
    this(fontName, text, fontSize, x, y, xSize, ySize, color(0));
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

    addChild(new Widget(0, 0, getWidth(), getHeight()));
    getBackground().setSelectedBorderColor(color(255));
  }

  void setDrawBackground(boolean status) {
    drawBackground = status;
  }

  void setLabel(String text) {
    this.text = text;
  }

  Widget getBackground() {
    Widget background = (Widget) getChild(0);
    return background;
  }

  void draw() {
    if ( drawBackground ) {
      getBackground().draw();
    }
    textFont(WidgetFont);
    fill(getColor());
    text(text, getEffectiveX(), getEffectiveY(), getWidth(), getHeight());
  }
}
