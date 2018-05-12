
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

  void render() {
    if (hasImage) {
      image(this.back, this.x, this.y, this.w, this.h);
    } else {
      rect(x, y, w, h);
    }
  }

}
