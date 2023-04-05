class MapWidget extends Widget {
  // time for hell
  RShape mask;
  String[] stateAbbreviations;
  RShape map;
  RShape maskedMap;
  boolean changes;
  String selectedState;

  color selectedColor;
  color defaultColor;
  MapWidget(int x, int y, int width, int height, String mapFile) {
    changes = false;
    setX(x);
    setY(y);
    setWidth(width);
    setHeight(height);
    map = RG.loadShape(mapFile);

    // position + scale
    float xDifference = width-map.width;
    float yDifference = height-map.height;

    float differencePercent;

    differencePercent = getHeight()/map.height;
    map.translate(getEffectiveX()+xDifference/2, getEffectiveY()+yDifference/2);
    map.scale(differencePercent, getEffectiveX()+getWidth()/2, getEffectiveY()+getHeight()/2);
    

    map.setFill(color(0));

    mask = RShape.createRectangle(getEffectiveX(), getEffectiveY(), width, height);

    String[] abbr = new String[]{"AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI",
      "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA",
      "WV", "WI", "WY"};
    stateAbbreviations = abbr;
    selectedState = null;

    for ( int i = 0; i < stateAbbreviations.length; i++ ) {
      String abbrev = stateAbbreviations[i];
      map.getChild(abbrev).setFill(color(0));
    }
    mask();
  }

  void onMouseWheel(int wheel) {
    map.scale((float) Math.pow(1.1, wheel), mouseX, mouseY);
    changes = true;
  }

  void onMouseDragged(int mouseX, int mouseY, int pmouseX, int pmouseY) {
    map.translate(mouseX-pmouseX, mouseY-pmouseY);
    changes = true;
  }

  void checkCollisions(int mouseX, int mouseY) {
    if ( !super.isTouching(mouseX, mouseY) || !map.contains(mouseX, mouseY) ) {
      selectedState = null;
      return;
    } else if ( selectedState != null && maskedMap.getChild(selectedState).contains(mouseX, mouseY) ) {
      return; // no need, it's already selected.
    } else {
      // oh. where'd it go.
      for ( int i = 0; i < stateAbbreviations.length; i++ ) {
        if ( maskedMap.getChild(stateAbbreviations[i]).contains(mouseX, mouseY) ) {
          selectedState = stateAbbreviations[i];
        }
      }
    }
  }

  void draw() {
    super.drawThis();
    if ( changes ) {
      mask();
      changes = false;
    }
    fill(255);
    stroke(0);
    maskedMap.draw();
    if ( selectedState != null ) {
      fill(color(255, 0, 0));
      maskedMap.getChild(selectedState).draw();
    }
  }
  
  String getSelectedState() {
    return selectedState;
  }

  void mask() {
    RShape newMask;
    newMask = mask;
    maskedMap = new RShape(map);
    maskedMap.translate(getEffectiveX(), getEffectiveY());
    maskedMap = map.intersection(newMask);
  }
}
