
/*
  Classe représentant une unité
*/

// TODO : Ajouter une liste d'unités ! Ont doit savoir à l'avance le nb d'unités

class Unit {

  /*
    - lives : points de vie restant
    - damages : points de dégat
    - moves : déplacement (en nombre de case)
    - side : camp de l'unité (1 : alliée, 2 : ennemie)
    - image : index du tableaux des images correspondant à la sprite de l'unité
  */
  
  int lives, damages, moves, side, image;
  
  Unit(int lives, int damages, int moves, int side, int image) {
  
    this.lives = lives; this.damages = damages;
    this.moves = moves;
    this.side = side;
    this.image = image;
  
  }

}