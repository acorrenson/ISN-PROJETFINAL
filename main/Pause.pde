
/*
  Class Pause
*/

class Pause extends State {
  
  /*
    coated : l'état du jeu, avant la mise en pause
    paused : l'affichage du jeu avant la mise en pause
    back   : l'image du menu
  */
  
  State coated;
  Button[] buttons;
  PImage paused, back, hover;
  int x,y;

  Pause(State coated) {
    super("Pause");  
    this.coated = coated;
    this.back = assets[25];
    this.hover = assets[26];
    this.paused = get(0,0, width,height);
    this.x = (width / 2) - (back.width / 2);
    this.y = (height / 2) - (back.height / 2);
    
    this.buttons = new Button[4];
    this.buttons[0] = new Button("Leave",   this.x + 177, this.y + 4,   14,  14);
    this.buttons[1] = new Button("Play",    this.x + 44,  this.y + 146, 107, 23);
    this.buttons[2] = new Button("Options", this.x + 44,  this.y + 210, 107, 23);
    this.buttons[3] = new Button("Quit",    this.x + 44,  this.y + 274, 107, 23);
  }
  
  void load() {
    
    println("!> Enter in pause state");
  
  }
  
  void update() {
    
    for (int i = 0; i < this.buttons.length; i ++ ) {
    
      if ( collide(mouseX, mouseY, this.buttons[i].x, this.buttons[i].y, this.buttons[i].w, this.buttons[i].h) ) {
        this.buttons[i].overflew = true;
      } else if ( this.buttons[i].overflew ) {
        this.buttons[i].overflew = false;
      }
      
      if ( mousePressed && this.buttons[i].overflew ) {
      
        action(this.buttons[i].name);
      
      }
    
    }
    
  }
  
  void render() {
    
    background(paused);
    filter(GRAY);
    filter(BLUR, 2);
    image(this.back, this.x, this.y);
    
    for (int i = 0; i < this.buttons.length; i ++ ) {
    
      if ( this.buttons[i].overflew ) {
        image(this.hover, this.buttons[i].x, this.buttons[i].y, this.buttons[i].w, this.buttons[i].h);
      }
      
    }
    
  }
  
  void action(String name) {
  
    if ( name.equals("Leave") || name.equals("Play") ) leave();
    
    else if ( name.equals("Options") ) println("!> Options");
    
    else if ( name.equals("Quit") ) println("!> Quit")
  
  }
  
  void keyDown(int k) {
  
    if (k == 27) {
      this.leave();
    }
    
  }
  
  void leave() {
  
    println("!> Leave pause state");
    actualState = coated;
  
  }

}
