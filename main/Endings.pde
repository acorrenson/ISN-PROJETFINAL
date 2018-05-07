/*
  Etats correspondant aux fins du jeu : gagné, perdu, credits
*/

class EndScreen extends State {
  
  Button[] buttons;
  boolean win;
  PImage back;
  String title;  

  EndScreen(boolean win) {
    // Constructeur de la classe
    super("End");
    this.win = win;
  }
  
  void load() {
  
    if ( this.win ) {    
      this.title = "VICTOIRE";
      // this.back = assets[?]     
    } else {
      this.title = "DEFAITE";
      // this.back = assets[? + 1]
    }
    
    this.buttons = new Button[2];
    this.buttons[0] = new Button("Play", 0, height - 64, 64, 32);
    this.buttons[1] = new Button("Quit", 0, height - 32, 64, 32);
  }
  
  void render() {
    background(0);
    
    fill(255);
    textFont(pixelFont);
    textAlign(CENTER, CENTER);
    textSize(25);
    text(this.title, width / 2, height / 2);
  
    for (int i = 0; i < this.buttons.length; i ++) {
      if ( this.buttons[i].hover() ) {
        image(assets[25], this.buttons[i].x, this.buttons[i].y, this.buttons[i].w, this.buttons[i].h);
      }
    }
  }

}
