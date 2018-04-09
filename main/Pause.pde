
/*
  Class Pause
*/

class Pause extends State {
  
  /*
    coated : l'état du jeu, avant la mise en pause
    paused : l'affichage du jeu avant la mise en pause
  */
  
  State coated;
  PImage paused, back;

  Pause(State coated) {
    super("Pause");  
    this.coated = coated;
    this.back = assets[25];
  }
  
  void load() {
    
    println("!> Enter in pause state");
    paused = get(0,0, width,height);
  
  }
  
  void update() {}
  
  void render() {
    
    background(paused);
    filter(GRAY);
    filter(BLUR, 2);
    image(back, (width / 2) - (back.width / 2), (height / 2) - (back.height / 2)); 
    
  }
  
  void keyDown(int k) {
  
    if (k == 27) {
      println("!> Leave pause state");
      actualState = coated;
    }
    
  }

}
