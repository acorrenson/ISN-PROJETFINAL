
/*
  Class représentant une carte
*/

class Card {
  
  /*
    - initX (initY) - : indique la position d'orginie (en px) de la carte (pour pouvoir la replacer si elle n'est pas sur le plateau)
    - x (y) --------- : indique la position actuelle (en px) de la carte
    - w (h) --------- : indique les dimensions d'une carte
    - lives --------- : vie de l'unité (pour l'affichage)
    - damages ------- : points de dégat de l'unité (pour l'affichage)
    - step ---------- : déplacement de l'unité (pour l'affichage)
    - name ---------- : indique le nom de l'unité correspondant à cette carte (pour récupérer l'image, les points de vie, etc ...)
    - cardBack ------ : image d'une carte
    - cardUnit ------ : image, unité à afficher
    - selected ------ : si la carte est séléctionnée
    - clickW (clickH) : position de la souris sur la carte (lors d'un clic)
  */

  int initX, initY, x, y, w, h;
  int lives, dmg, step;
  String name;
  PImage cardBack, cardUnit;

  boolean selected;

  int clickW;
  int clickH;

  Card(String name, int... coords) {
    
    // Constructeur de la classe
    
    this.initX = coords[0];
    this.initY = coords[1];
    this.x = this.initX;
    this.y = this.initY;
    this.name = name;
    
    JSONObject data = JSONUnits.getJSONObject(name);
    this.lives = data.getInt("lives");
    this.dmg = data.getInt("damages");
    this.step = data.getInt("step");
    
    this.cardBack = assets[35];
    this.cardUnit = assets[ gai(name, 0, 0) ];

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
  
  boolean isOverflown() {
    if ( collide(mouseX, mouseY, this.x, this.y, this.w, this.h) ) return true;
    else return false;
  }

  void render(boolean enable) {
    
    /*
      Affichage d'une carte
        Si elle n'est pas séléctionnée
          - on trace un rectangle depuis (x;y) (point en haut à gauche) jusqu'à (x + w; y+ h) (point en bas à droite)
        Si elle est séléctionnée
          - idem sauf que le point en HG est déterimé par la position x (y) de la souris, moins le x (y) où la carte a été cliqué
    */
    
    if ( !enable ) tint(100, 100, 100);
    if(!this.selected) {
      drawCard( this.x, this.y );
    } else {
      drawCard( mouseX - this.clickW, mouseY - this.clickH );
    }
    noTint();
  }
  
  void drawCard(int drawX, int drawY) {
  
    image( cardBack, drawX, drawY, w, h );
    image( cardUnit, drawX + 2, drawY + 2, 64, 64 );
    
    fill(255);
    textFont(pixelFont);
    textSize(5);
    textAlign(CENTER, CENTER);
    text(this.lives, drawX + 15, drawY + 83);    
    text(this.dmg, drawX + 51, drawY + 83);
    text(this.step, drawX + 33, drawY + 101);
  
  }
}
