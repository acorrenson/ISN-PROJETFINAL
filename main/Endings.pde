/*
  Etats correspondant aux fins du jeu : gagné, perdu, credits
*/

class EndScreen extends State {
  
  /*
    next -- : bouton pour passer à l'écran suivant (credits)
    win --- : si la partie est gagnée
    title - : si win = true, title = "VICTOIRE", sinon, title = "DEFAITE"
  */
  
  Button next;
  boolean win;
  String title;

  EndScreen(boolean win) {
    // Constructeur de la classe
    super("End");
    this.win = win;
  }
  
  void load() {
  
    if ( this.win ) {    
      this.title = "VICTOIRE";  
    } else {
      this.title = "DEFAITE";
    }
    
    this.next = new Button("Continuer", 167, 495, 181, 19);
  }
  
  void mousePressed() {
  
    if (this.next.hover()) this.leave();
    
  }
  
  void render() {
    background(0);
    
    fill(255);
    textFont(pixelFont);
    textAlign(CENTER, CENTER);
    textSize(25);
    text(this.title, width / 2, height / 4);
    textSize(15);
    text(this.next.name, width / 2, (height * 3) / 4);
  
    if ( this.next.hover() ) {
      image(assets[25], this.next.x, this.next.y, this.next.w, this.next.h);
    }
  }
  
  void leave() {  
    enterState( new Credits() );
  }

}

class Credits extends State {
  
  /*
    replay - : bouton qui renvoit au tuto (pour rejouer)
    text --- : texte des crédits
  */

  Button replay;
  String text;
  
  Credits() {
    super("credits");
  }
  
  void load() {
    String[] lines = loadStrings("data/credits.txt");
    text = join(lines, "\n");
    
    replay = new Button("Rejouer", 209, 655, 94, 14);
  }
  
  void mousePressed() {
  
    if (replay.hover()) this.leave();
    
  }
  
  void render() {
    background(0);
    
    if (this.replay.hover()) { image(assets[25], this.replay.x, this.replay.y, this.replay.w, this.replay.h); }
    
    fill(255);
    textFont(pixelFont);
    textSize(10);
    textAlign(CENTER, CENTER);
    text(text, 0, 0, width, height);
    text(this.replay.name, width / 2, height - 10);
  }
  
  void leave() {
    enterState( new Tuto() );
  }

}
