// UNE CARTE
class Card {
  
  /*
    - initX (initY) - : indique la position d'orginie en px) de la carte (pour pouvoir la replacer si elle n'est pas sur le plateau)
    - x (y) --------- : indique la position actuelle (en px) de la carte
    - w (h) --------- : indique les dimensions d'une carte
    - name ---------- : indique le nom de l'unité correspondant à cette carte (pour récupérer l'image, les points de vie, etc ...)
    - selected ------ : si la carte est séléctionnée
    - clickW (clickH) : position de la souris sur la carte (lors d'un clic)
  */

  int initX;
  int initY;
  int x;
  int y;
  int w;
  int h;
  String name;

  boolean selected;

  int clickW;
  int clickH;

  Card(int x, int y, String name) {
    
    // Constructeur de la classe
    
    this.initX = x;
    this.initY = y;
    this.x = this.initX;
    this.y = this.initY;
    this.name = name;

    this.w = cardWidth;
    this.h = cardHeight;
  }

  void select() {
    
    /*
      Quand la carte est séléctionnée :
        - clickW (clickH) prend la valeur x (y) de la souris, moins la position x (y) de la carte
    */
    
    this.selected = true;
    this.clickW = mouseX - this.x;
    this.clickH = mouseY - this.y;
  }

  void reset() {
    
    /*
      Quand on lache la carte en dehors du plateau
        - on la replace à sa position d'origine
        - on dit qu'elle n'est plus séléctionnée
    */
    
    this.x = this.initX;
    this.y = this.initY;
    this.selected = false;
  }

  void render() {
    
    /*
      Affichage d'une carte
        Si elle n'est pas séléctionnée
          - on trace un rectangle depuis (x;y) (point en haut à gauche) jusqu'à (x + w; y+ h) (point en bas à droite)
        Si elle est séléctionnée
          - idem sauf que le point en HG est déterimée par la position x (y) de la souris, moins le x (y) où la carte a était cliquée
    */
    
    fill(255);
    if(!this.selected) {
      rect(this.x, this.y, this.w, this.h);
    } else {
      rect(mouseX - this.clickW, mouseY - this.clickH, this.w, this.h);
    }
  }
}
