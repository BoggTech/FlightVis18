int SCREENX = 495;
int SCREENY = 500;
int minDate;
int maxDate;

float lastSliderX = 0;

PFont font;

Slider slider1;
Slider slider2;
Track theTrack;

void settings() {
  size( SCREENX, SCREENY );
}

void setup() {
  theTrack = new Track();
  slider1 = new Slider( true ); // isLeftSlider will be true
  slider2 = new Slider( false ); // is RightSlider will be true
  font = createFont( "AgencyFB-Bold", 20 );
}



void draw() {
  background( 255 );
  if ( mousePressed ) {
    if ( !slider2.getSliderClickedStatus() ) {
      slider1.click();
    }
    if ( !slider1.getSliderClickedStatus() ) {
      slider2.click();
    }
  }
  else {
    slider1.unClick();
    slider2.unClick();
  }
  
  slider1.slide();
  lastSliderX = slider2.getSliderX();
  slider1.reposition();
  slider2.slide();
  lastSliderX = slider1.getSliderX();
  slider2.reposition();
  
  slider1.setDate();
  slider2.setDate();
  minDate = slider1.getDate();
  maxDate = slider2.getDate();
  
  theTrack.draw();
  slider1.draw();
  slider2.draw();
  textFont ( font );
  fill ( 0 );
  text( minDate, theTrack.getTrackX(), 100 );
  text( maxDate, ( theTrack.getTrackX() + theTrack.getTrackWidth() ), 100 );
}
