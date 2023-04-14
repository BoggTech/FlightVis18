// Button // Author: Darryl
// Basically just a widget w/ a text label. Widget already has a lot of the functionality.
class Button extends Widget {
  // LOTS of duplicate constructors; most just for convenience.
  Button() {
    this(0, 0, 0, 0, BUTTON_COLOR, null);
  }

  Button(float x, float y, float width, float height) {
    this(x, y, width, height, BUTTON_COLOR, null);
  }

  Button(float x, float y, float width, float height, Widget parent) {
    this(x, y, width, height, BUTTON_COLOR, parent);
  }

  Button(float x, float y, float width, float height, color widgetColor) {
    this(x, y, width, height, widgetColor, null);
  }

  Button(float x, float y, float width, float height, color widgetColor, Widget parent) {
    this(x, y, width, height, widgetColor, "", parent);
  }

  Button(float x, float y, float width, float height, color widgetColor, String label, Widget parent) {
    super(x, y, width, height, widgetColor, parent);
    addChild(new TextWidget("", label, (int) height, 0, 0, width, height));
  }

  // return the TextWidget object for the label
  private TextWidget getLabel() {
    TextWidget textWidget = (TextWidget) getChild(0);
    return textWidget;
  }

  // set the String value of the label's label (yeah that naming convention gets confusing)
  void setLabel(String label) {
    getLabel().setLabel(label);
  }

  // set size of the text widget's label
  void setLabelSize(int size) {
    getLabel().setTextSize(size);
  }

  // set the text-align type for the text widget's label
  void setAlign(int alignment) {
    getLabel().setAlign(alignment);
  }

  // shift the TextWidget's label, can make it easier to adjust it and make it look right.
  void moveLabel(int x, int y) {
    getLabel().move(x, y);
  }
  
  // set the color of the label text.
  void setLabelColor(color newColor) {
    getLabel().setColor(newColor);
  }
}
