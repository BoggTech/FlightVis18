class MapWidget extends Widget {
  // time for hell

  final float MIN_SCALE = 1;
  final float MAX_SCALE = 2;
  RShape mask;
  String[] stateAbbreviations;
  RShape originalMap;
  RShape map;
  RShape maskedMap;
  boolean changes;
  String selectedState;
  
  float mapCenterX;
  float mapCenterY;
  int max_x;
  int max_y;

  float scale;

  color selectedColor;
  color defaultColor;
  MapWidget(int x, int y, int width, int height, String mapFile) {
    changes = false;
    setX(x);
    setY(y);
    setWidth(width);
    setHeight(height);
    originalMap = RG.loadShape(mapFile);
    max_x = width;
    max_y = height;

    // position + scale
    scale = 1;
    float xDifference = width-originalMap.width;
    float yDifference = height-originalMap.height;

    float differencePercent;

    differencePercent = getHeight()/originalMap.height;
    originalMap.translate(getEffectiveX()+xDifference/2, getEffectiveY()+yDifference/2);
    originalMap.scale(differencePercent, getEffectiveX()+getWidth()/2, getEffectiveY()+getHeight()/2);


    originalMap.setFill(color(0));

    map = new RShape(originalMap);
    calculateCenterPoint();

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
    float newScale = (float) (scale * Math.pow(1.1, wheel));
    float newX;
    float newY;
    if ( newScale >= MIN_SCALE && newScale <= MAX_SCALE ) {
      map.scale((float) Math.pow(1.1, wheel), mouseX, mouseY);
      scale = newScale;
    } else if ( newScale < MIN_SCALE ) {
      newX = map.getX();
      newY = map.getY();
      map = new RShape(originalMap);
      map.scale(MIN_SCALE);
      map.translate(newX-map.getX(), newY-map.getY());
      scale = MIN_SCALE;
    } else if ( newScale > MAX_SCALE ) {
      newX = map.getX();
      newY = map.getY();
      map = new RShape(originalMap);
      map.scale(MAX_SCALE);
      map.translate(newX-map.getX(), newY-map.getY());
      scale = MAX_SCALE;
    }
    changes = true;
  }

  void onMouseDragged(int mouseX, int mouseY, int pmouseX, int pmouseY) {
    //calculateCenterPoint();
    //TODO: Limits
    float translateX = mouseX-pmouseX;
    float translateY = mouseY-pmouseY;
    /*float newX = mapCenterX+translateX;
    float newY = mapCenterY+translateY;
    
    println(abs(newX));
    
    if ( abs(newX) > max_x ) {
      if ( newX > max_x+getEffectiveX() ) {
        translateX = translateX-(newX-(max_x+getEffectiveX()));
      } else {
        translateX = translateX-(newX-max_x-getEffectiveX());
      }
    }
    if ( abs(newY) > (max_y+getEffectiveY()) ) {
      if ( newY < -max_y ) {
        translateY = translateY-(newY+max_y+getEffectiveY());
      } else {
        translateY = translateY-(newY-max_y-getEffectiveY());
      }
    }*/
    map.translate(translateX, translateY);
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
  
  void calculateCenterPoint() {
    mapCenterX = map.getX() + (map.width/2);
    mapCenterY = map.getY() + (map.height/2);
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
