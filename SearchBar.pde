class SearchBar extends Widget{
  
  ArrayList<String> insideSearchBar = new ArrayList<String>();
  private int textLimit = 40;
  boolean enterPressed=false;
  public float currentValue;
  public int lastLetterTyped;
  public String textValue="";

  public char keyInput;
  public char currentKeyPress;
  public boolean keyReleased;
  public String letterAdd;

  String stringReturn;
  
  SearchBar(){
    
  }
  
  void draw(){
 
    getUserInput();
    
  }
  
  
  
  void getUserInput() {
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
    
    if(key==ENTER){
      enterPressed=true;
    }
  }
}
