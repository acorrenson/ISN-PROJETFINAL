
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
  PImage paused, back, hover;
  int x,y, hX,hY;

  Pause(State coated) {
    super("Pause");  
    this.coated = coated;
    this.back = assets[25];
    this.hover = assets[26];
    this.x = (width / 2) - (back.width / 2);
    this.y = (height / 2) - (back.height / 2);
    this.hX = -this.hover.width;
    this.hY = -this.hover.height;
  }
  
  void load() {
    
    println("!> Enter in pause state");
    paused = get(0,0, width,height);
  
  }
  
  void update() {
    
  }
  
  void render() {
    
    background(paused);
    filter(GRAY);
    filter(BLUR, 2);
    image(this.back, this.x, this.y);
    image(this.hover, this.hX, this.hY);
    
  }
  
  void keyDown(int k) {
  
    if (k == 27) {
      println("!> Leave pause state");
      actualState = coated;
    }
    
  }

}
