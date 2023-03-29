class TextWidget {
  
  String fontName;
  int fontSize;
  PFont WidgetFont;
  
  float textX;
  float textY;
  float xSize;
  float ySize;
  
  String text;
  
  color textColor;
  
  TextWidget( String fontInputted ) {
   
    fontName = fontInputted;
  
  }
  
  void draw( String textInputted, int fontSizeInputted, float xInputted, float yInputted, float xSizeInputted, float ySizeInputted, color colorInputted ) {
    
    text = textInputted;
    fontSize = fontSizeInputted;
    textX = xInputted;
    textY = yInputted;
    xSize = xSizeInputted;
    ySize = ySizeInputted;
    textColor = colorInputted;
    
    
    WidgetFont = createFont ( fontName, fontSize );
    textFont ( WidgetFont );
    fill ( textColor );
    text( text, textX, textY, xSize, ySize );
  }
  
}
