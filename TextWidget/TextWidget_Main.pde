final int SCREENX = 600;
final int SCREENY = 600;

String inputFont = "AgencyFB-Bold";
int fontSize = 36;
String inputText = "Sample Text";

float inputX = 400;
float inputY = 100;
float textBoxX = 500;
float textBoxY = 200;
color inputColor = color( 0, 0, 0 );

PFont font;

TextWidget aTextWidget;

void settings() {
  size( SCREENX, SCREENY );
}

void setup() {
  background( 100 );
  aTextWidget = new TextWidget( inputFont );
}

void draw() {
  aTextWidget.draw( inputText, fontSize, inputX, inputY, textBoxX, textBoxY, inputColor );
}
