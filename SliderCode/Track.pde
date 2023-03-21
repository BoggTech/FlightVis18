class Track {
  
  float trackWidth = 309;
  float trackHeight = 10;
  float trackX = 95;
  float trackY = 200; // this has to be set differently
  
  float getTrackX() {
    return trackX;
  }
  
  float getTrackY() {
    return trackY;
  }
  float getTrackWidth() {
    return trackWidth;
  }
  
  float getTrackHeight() {
    return trackHeight;
  }
  
  void draw () {
    fill( 255, 0, 0 );
    rect( trackX, trackY, trackWidth, trackHeight );
  }
  
}
