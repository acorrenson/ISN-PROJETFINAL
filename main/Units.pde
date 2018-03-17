
// Objet référançant tous les types d'unités (JSON)
JSONObject JSONUnits;

// TODO : Ajouter les positions de l'unité !
class Unit {

  /*
    - lives : points de vie restants
    - maxLives : points de vie maximums
    - damages : points de dégât
    - moves : déplacement (en nombre de cases)
    - side : camp de l'unité (1 : alliée, 2 : ennemie)
    - textures : objet indiquant les index des textures de l'unité dans le tableau des images
  */
  
  String name;
  int lives, maxLives, damages, moves, side;
  JSONObject textures;
  
  Unit(JSONObject unitDatas, int side) {
    
    this.side = side;
    this.maxLives = unitDatas.getInt("lives");
    this.lives = this.maxLives;
    this.damages = unitDatas.getInt("damages");
    this.moves = unitDatas.getInt("moves");
    this.textures = unitDatas.getJSONArray("textures").getJSONObject(0);
    // this.textures = unitDatas.getJSONObject("textures").getJSONObject("myFaction");
  }

}