
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
    - faction -- : camp de l'unité (0 : alliée, 1 : ennemie)
    - idSprite - : index de "assets" de l'image de l'unité
  */
  
  String name;
  int lives, maxLives, damages, step, faction, idSprite;
  
  Unit(int faction, String name) {
    
    // Constructeur de la classe
    
    JSONObject data = JSONUnits.getJSONObject(name);
    this.name = name;
    this.faction = faction;
    this.maxLives = data.getInt("lives");
    this.lives = this.maxLives;
    this.damages = data.getInt("damages");
    this.step = data.getInt("step");
    this.idSprite = gai(name, faction, 1);
  }
  
  void render(int x, int y) {
    
    /*
      Affichage d'une unité
    */
    
    fill(255, 0, 0);
    rect(x, y, sqrSize, sqrSize);
    fill(255);
    text(this.name, x, y);
  }
}
