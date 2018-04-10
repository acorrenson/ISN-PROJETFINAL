
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
}

class Button extends Widget {
  
  boolean overflew;

  Button(String name, int x, int y, int w, int h) {
    
    super(name, x, y, w, h);
    this.overflew = false;
    
  }

}
