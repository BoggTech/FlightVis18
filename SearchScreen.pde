class SearchScreen extends Screen{
  
  Button searchBar;
  Button enter;
  Button date; 
  Button origin;
  Button destination;
  Button arrTime;
  Button depTime;
  
  SearchScreen(){
    
    searchBar = new Button(150, 0, 400, 75);
    searchBar.setEvent(1);
    enter = new Button(550, 0, 50, 75);
    enter.setEvent(2);
    date = new Button(0, 0, 150, 75);
    date.setEvent(3);
    origin = new Button(0, 75, 150, 75);
    origin.setEvent(4);
    destination = new Button(0, 150, 150, 75);
    destination.setEvent(5);
    arrTime = new Button(0, 225, 150, 75);
    arrTime.setEvent(6);
    depTime = new Button(0, 300, 150, 75);
    depTime.setEvent(7);
    
    addWidget(searchBar);
    addWidget(enter);
    addWidget(origin);
    addWidget(date);
    addWidget(destination);
    addWidget(arrTime);
    addWidget(depTime);
    
  }
  
  void draw(){
    
    fill(255);
    textSize(32);
    //text("Search Bar", 100, 200);
    screen.checkCollisions(mouseX, mouseY);
    super.draw();
  
 }
  
}
