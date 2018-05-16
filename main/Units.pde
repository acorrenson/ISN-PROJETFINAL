
/*
  Classe représentant une unité
*/

JSONObject JSONUnits;

class Unit {

  /*
    - lives ---- : points de vie restants
    - maxLives - : points de vie maximums
    - damages -- : points de dégât
    - step ----- : déplacement (en nombre de cases)
    - steps ---- : pas déjà fait durant le tour
    - faction -- : camp de l'unité (0 : alliée, 1 : ennemie)
    - idSprite - : index de "assets" de l'image de l'unité
  */
  
  String name;
  int lives, maxLives, damages, step, faction, side, idSprite;
  int steps;
  
  Unit(String name, int faction, int side) {
    
    // Constructeur de la classe
    
    JSONObject data = JSONUnits.getJSONObject(name);
    this.name = name;
    this.faction = faction; this.side = side;
    this.maxLives = data.getInt("lives");
    this.lives = this.maxLives;
    this.damages = data.getInt("damages");
    this.step = data.getInt("step");
    this.steps = 0;
    this.idSprite = gai(name, faction, side);
  }

  void stop() {
    this.steps = this.step;
  }
  
  boolean canMove() {
    return this.steps < this.step;
  }
  
  boolean isOverflown(int x, int y) {
    if ( collide(mouseX, mouseY, x, y, 64, 64) ) return true;
    else return false;
  }

  void render(int x, int y) {
    
    /*
      Affichage d'une unité
    */
    
    if ( isOverflown(x, y) ) {
      dispInfos = true;
      dispUnit = gai(this.name, this.faction, 0);
      dispLives = this.lives;
      dispAtk = this.damages;
      dispStep = this.step;
    }
    
    image(assets[this.idSprite], x, y, 64, 64);
    fill(255);
    textAlign(LEFT, BASELINE);
    textSize(5);
    text(this.name, x, y);
  }
}
