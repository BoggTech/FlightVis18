class SearchBar extends Widget {

  ArrayList<String> insideSearchBar = new ArrayList<String>();
  private int textLimit = 40;
  boolean selected = false;

  SearchBar() {
    this(0, 0, 0, 0, color(0), null);
  }

  SearchBar(float x, float y, float width, float height) {
    this(x, y, width, height, color(128), null);
  }

  SearchBar(float x, float y, float width, float height, Widget parent) {
    this(x, y, width, height, color(128), parent);
  }

  SearchBar(float x, float y, float width, float height, color widgetColor) {
    this(x, y, width, height, widgetColor, null);
  }

  SearchBar(float x, float y, float width, float height, color widgetColor, Widget parent) {
    super(x, y, width, height, widgetColor, null);
    addChild(new TextWidget((int) x, (int) y, (int) width, (int) 1200));
  }

  void draw() {
    TextWidget label = getLabel();
    String originalLabel = label.getLabel();
    if ( frameCount % 80 < 40 && selected && insideSearchBar.size() < 40 ) {
        label.setLabel(label.getLabel() + "|");
      }
    super.draw();
    label.setLabel(originalLabel);
  }

  TextWidget getLabel() {
    TextWidget label = (TextWidget) getChild(0);
    return label;
  }

  void onClick(int mouseX, int mouseY) {
    if ( isTouching(mouseX, mouseY) ) {
      selected = true;
      setColor(255);
      setSelectedBorderColor(0);
      setDefaultBorderColor(255);
      getLabel().setColor(0);
    } else {
      selected = false;
      setColor(0);
      getLabel().setColor(255);
      setSelectedBorderColor(255);
      setDefaultBorderColor(0);
    }
  }

  void onKeyPressed(char keyValue) {
    if ( selected ) {
      if ( keyValue == BACKSPACE ) {
        if ( insideSearchBar.size() > 0 ) {
          insideSearchBar.remove(insideSearchBar.size()-1);
        }
      } else {
        if ( insideSearchBar.size() < textLimit
          && (keyValue <= 'Z' && keyValue >= 'A'
          || keyValue <= 'z' && keyValue >= 'a') )
          insideSearchBar.add(String.valueOf(keyValue));
      }
      String label = "";
      for ( int i = 0; i < insideSearchBar.size(); i++ ) {
        label += insideSearchBar.get(i);
      }
      TextWidget text = getLabel();
      text.setLabel(label);
    }
  }
}
