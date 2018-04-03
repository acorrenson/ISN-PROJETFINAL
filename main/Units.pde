
// Objet référançant tous les types d'unités (JSON)
JSONObject JSONUnits;

// TODO : Ajouter les positions de l'unité !
class Unit {

  /*
    - lives : points de vie restants
    - maxLives : points de vie maximums
    - damages : points de dégât
    - moves : déplacement (en nombre de cases)
    - faction : camp de l'unité (1 : alliée, 2 : ennemie)
    - textures : objet indiquant les index des textures de l'unité dans le tableau des images
  */
  
  String name;
  int lives, maxLives, damages, moves, faction;
  JSONObject textures;
  
  Unit(int faction, String name) {
    JSONObject data = JSONUnits.getJSONObject(name);
    this.name = name;
    this.faction = faction;
    this.maxLives = data.getInt("lives");
    this.lives = this.maxLives;
    this.damages = data.getInt("damages");
    this.moves = data.getInt("moves");
    //this.textures = data.getJSONArray("textures").getJSONObject(this.faction);
  }
  
  void render(int x, int y) {
    fill(255, 0, 0);
    rect(x, y, sqrSize, sqrSize);
    fill(255);
    text(this.name, x, y);
  }
}
