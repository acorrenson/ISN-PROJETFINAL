
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
    - damaged -- : si l'unité subit des domages
  */
  
  String name;
  int lives, maxLives, damages, step, faction, side, idSprite;
  int steps;
  boolean damaged;
  
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
    this.damaged = false;
  }

  void stop() {
    
    /* Réinitialise les pas de l'unité */
    
    this.steps = this.step;
  }
  
  boolean canMove() {
    
    /* Renvoie true si l'unité peut se déplacer */
    
    return this.steps < this.step;
  }
  
  boolean isOverflown(int x, int y) {
    
    /* Renvoie true si l'unité est survolée */
    
    if ( collide(mouseX, mouseY, x, y, 64, 64) ) return true;
    else return false;
  }

  void render(int x, int y) {
    
    /*
      Affichage d'une unité
        Si elle est survolée:
          - Modifie les variables générales à afficher dans infos
        Si l'unité subit des domages (damaged = true)
          - Applique un effet "tint" rouge
    */
    
    if ( isOverflown(x, y) ) {
      dispInfos = true;
      dispUnit = gai(this.name, this.faction, 0);
      dispLives = this.lives;
      dispAtk = this.damages;
      dispStep = this.step;
    }
    
    if ( this.damaged ) tint(200, 0, 0);
    
    image(assets[this.idSprite], x, y, 64, 64);
    fill(255);
    textAlign(LEFT, BASELINE);
    textSize(5);
    text(this.name, x, y);
    
    noTint();
    
  }
}
