class Button extends Widget {
  private String label;

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
    this(x, y, width, height, widgetColor, "", null);
  }

  Button(float x, float y, float width, float height, color widgetColor, String label, Widget parent) {
    super(x, y, width, height, widgetColor, parent);
    this.label = label;
    addChild(new TextWidget("", label, (int) height, 0, 0, width*2, height*2));
  }

  void setLabel(String label) {
    TextWidget textWidget = (TextWidget) getChild(0);
    textWidget.setLabel(label);
  }
}
