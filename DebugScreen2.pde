class DebugScreen2 extends Screen {
  Button button;
  DebugScreen2() {
    super();
    button = new Button(10, 110, 30, 30);
    button.setEvent(GLOBAL_EVENT_DEBUG_1);
    
    addWidget(button);
  }
  
  boolean handleEvent(int event) {
    return true;
  }
}
