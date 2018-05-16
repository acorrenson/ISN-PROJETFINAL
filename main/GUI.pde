
/*
  Graphical User Interface
    Les objets de l'interface graphique (par exemple : bouton, zone de saisie, etc ...) 
*/

class Widget {
  
  /*
    name ------- : nom du widget (peut être affiché)
    x, y, w, h - : respectivement les coordonnées et les dimensions du widget (en px)
  */
  
  String name;
  int x, y, w, h;

  Widget(String name, int x, int y, int w, int h) {
    
    this.name = name;
    this.x = x; this.y = y;
    this.w = w; this.h = h;
    
  }

  boolean hover() {
    
    /* Renvoie true si le widget est survolé */
    
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      return true;
    }
    return false;
  }
}

class Button extends Widget {
  
  /*
    hasImage - : si le bouton possède une image
    back ----- : image à afficher
  */

  boolean hasImage;
  PImage back;
  
  // Nous utilisons deux constructeurs : il s'agit d'une astuce java qui nous permet d'initialiser un bouton avec ou sans image de fond (paramètre PImage back)

  Button(String name, int x, int y, int w, int h) {
    
    super(name, x, y, w, h);
    this.hasImage = false;
  }

  Button(String name, int x, int y, int w, int h, PImage back) {
    
    super(name, x, y, w, h);
    this.back = back;
    this.hasImage = true;
  
  }

  void render(color fg, color tc) {
    if (hasImage) {
      image(this.back, this.x, this.y, this.w, this.h);
    } else {
      fill(fg);
      rect(x, y, w, h);
    }

    fill(tc);
    textAlign(CENTER, CENTER);
    text(this.name, this.x + this.w/2, this.y + this.h/2);
  }

}

void renderInfos() {
  
  /* Affiche les informations (si dispInfos = true) de l'unité ou de la carte survolée */ 
  
  if ( dispInfos ) {
    int x = width - assets[41].width, y = height / 4;
    image(assets[41], x, y);
    image(assets[dispUnit], x + 5, y + 13);
    textAlign(LEFT, TOP);
    textSize(15);
    fill(225, 99, 99);
    text(dispLives, x + 215, y);
    fill(208, 99, 225);
    text(dispAtk, x + 215, y + 20);
    fill(108, 99, 225);
    text(dispStep, x + 215, y + 40);
  }
  dispInfos = false;
}
