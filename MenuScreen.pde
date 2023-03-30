class MenuScreen extends Screen {
  ArrayList widgets;
  MenuScreen() {
    super();
    
    widgets = new ArrayList<>();
    
    for ( int i = 0; i < widgets.size(); i++ ) {
      Widget widget = (Widget) widgets.get(i);
      addWidget(widget);
    }
  }
}
