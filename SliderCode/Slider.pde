class Slider {
  
  float sliderWidth = 13;
  float sliderHeight = 40;
  float sliderX;
  float sliderY = 200;
  
  int date;
  
  boolean clicked = false;
  boolean isLeftSlider;
  
  Slider( boolean input ) {
    isLeftSlider = input;
    if ( isLeftSlider ) {
      sliderX = theTrack.getTrackX();
    }
    else {
      sliderX = theTrack.getTrackX() + theTrack.getTrackWidth();
    }
  }
  
  float getSliderX() {
    return sliderX;
  }
  
  float getSliderY() {
    return sliderY;
  }
  
  boolean getSliderClickedStatus() {
    return clicked;
  }
  
  void click() {
    if ( ( mouseX <= sliderX + sliderWidth ) && ( mouseX >= sliderX ) && ( mouseY >= sliderY ) && ( mouseY <= sliderY + sliderHeight ) ) {
      clicked = true;
    }
  }
  void unClick() {
    clicked = false;
  }
  
  void slide() {
    if ( clicked ){
      sliderX = mouseX - sliderWidth / 2;
    }
  }
  void reposition() {
    if ( isLeftSlider ) {
      if ( sliderX < theTrack.getTrackX() ) {
        sliderX = theTrack.getTrackX();
      }
      if ( sliderX > lastSliderX - sliderWidth ) {
        sliderX = lastSliderX - sliderWidth;
      }
    }
    else {
      if ( sliderX < lastSliderX + sliderWidth ) {
        sliderX = lastSliderX + sliderWidth;
      }
      if ( sliderX > theTrack.getTrackX() + theTrack.getTrackWidth() ) {
        sliderX = theTrack.getTrackX() + theTrack.getTrackWidth();
      }
    }
  }
  
  void setDate() {
    date = int ( ( sliderX - theTrack.getTrackX() ) / 10 ) + 1;
    if ( sliderX <= theTrack.getTrackX() + 13 ) { // constant that should be changed if other constants are changed
      date = 1;
    }
    if ( sliderX >= ( theTrack.getTrackX() + theTrack.getTrackWidth() ) - 13 ) { // constant that should be changed if other constants are changed
      date = 31;
    }
  }
  
  int getDate() {
    return date;
  }
  
  void draw () {
    fill( 0, 255, 0 );
    rect( sliderX, sliderY, sliderWidth, sliderHeight );
  }
  
}
