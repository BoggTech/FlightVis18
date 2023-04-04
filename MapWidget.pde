class MapWidget extends Widget {
  // time for hell
  String[] stateAbbreviations;
  StateWidget selectedState;
  StateWidget[] states;
  RShape map;

  MapWidget(int x, int y, int width, int height, String mapFile) {
    setX(x);
    setY(y);
    setWidth(width);
    setHeight(height);
    
    map = RG.loadShape(mapFile);
    String[] abbr = new String[]{"AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI",
      "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA",
      "WV", "WI", "WY"};
    stateAbbreviations = abbr;
  }
  
  void draw() {
    
  }
}

class StateWidget extends Widget {
  RShape state;
  String abbreviation;
  StateWidget(RShape state, String abbreviation) {
    this.state = state;
    this.abbreviation = abbreviation;
  }
  
  boolean isTouching(int mouseX, int mouseY) {
    if ( state.contains(mouseX, mouseY) ) {
      return true;
    }
    return false;
  }
  
  void draw() {
    
  }
}
