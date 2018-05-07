/*
  Etats correspondant aux fins du jeu : gagné, perdu, credits
*/

class EndScreen extends State {
  
  Button replay;
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
    
    this.replay = new Button("Play", 0, height - 64, 64, 32);
  }
  
  void mousePressed() {
  
    if (this.replay.hover()) this.leave();
    
  }
  
  void render() {
    background(0);
    
    fill(255);
    textFont(pixelFont);
    textAlign(CENTER, CENTER);
    textSize(25);
    text(this.title, width / 2, height / 2);
  
    if ( this.replay.hover() ) {
      image(assets[25], this.replay.x, this.replay.y, this.replay.w, this.replay.h);
    }
  }
  
  void leave() {  
    enterState( new Combat("combat_1") ); // Remplacer par state intro
  }

}

class Credits extends State {

  Button quit;
  String text;
  
  Credits() {
    super("credits");
  }
  
  void load() {
    String[] lines = loadStrings("data/credits.txt");
    text = join(lines, "\n");
    
    quit = new Button("Quit", 0, height - 32, 64, 32);
  }
  
  void mousePressed() {
  
    if (quit.hover()) this.leave();
    
  }
  
  void render() {
    background(0);
    
    if (quit.hover()) { image(assets[25], quit.x, quit.y, quit.w, quit.h); }
    
    fill(255);
    textFont(pixelFont);
    textSize(15);
    textAlign(CENTER, CENTER);
    text(text, 0, 0, width, height);
  }
  
  void leave() {
    enterState( new Combat("combat_1") ); // Remplacer par state intro
  }

}
