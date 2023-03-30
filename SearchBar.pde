class SearchBar extends Widget {

  ArrayList<String> insideSearchBar = new ArrayList<String>();
  private int textLimit = 40;
  boolean enterPressed = false;
  public float currentValue;
  public int lastLetterTyped;
  public String textValue="";
  public char keyInput;
  public char currentKeyPress;
  public boolean keyReleased;
  public String letterAdd;
  String stringReturn;
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
    super.draw();
  }

  TextWidget getLabel() {
    TextWidget label = (TextWidget) getChild(0);
    return label;
  }

  void onClick(int mouseX, int mouseY) {
    if ( isTouching(mouseX, mouseY) ) {
      selected = true;
      setColor(255);
    } else {
      selected = false;
      setColor(0);
    }
  }

  void onKeyPressed(char keyValue) {
    if ( selected ) {
      if ( keyValue == BACKSPACE ) {
        if ( insideSearchBar.size() > 0 ) {
          insideSearchBar.remove(insideSearchBar.size()-1);
        }
      } else {
        if ( insideSearchBar.size() < textLimit )
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

  /*void getUserInput() {
   if (keyPressed!=true) {
   keyReleased = true;
   }
   
   //"Key!=CODED" ignores Caps key
   if (keyPressed &&key!=CODED& keyReleased) {
   
   
   currentKeyPress = key;
   letterAdd=String.valueOf(currentKeyPress);
   insideSearchBar.add(letterAdd);
   println(insideSearchBar);
   
   
   if (currentKeyPress == BACKSPACE) {
   textValue = "";
   insideSearchBar.clear();
   } else if (currentKeyPress >= ' ') textValue += str(currentKeyPress);
   if (textValue.length() > textLimit) textValue = "";
   keyReleased = false;
   }
   
   if (key==ENTER) {
   enterPressed=true;
   }
   }*/
}
