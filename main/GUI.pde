
/*
  Graphical User Interface
    Les objets de l'interface graphique (par exemple : bouton, zone de saisie, etc ...) 
*/

class Widget {
  
  String name;
  int x, y, w, h;

  Widget(String name, int x, int y, int w, int h) {
    
    this.name = name;
    this.x = x; this.y = y;
    this.w = w; this.h = h;
    
  }

  boolean hover() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      return true;
    }
    return false;
  }
}

class Button extends Widget {

  PImage back;
  boolean hasImage;

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
