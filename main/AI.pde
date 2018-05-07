
class AI {

  Unit[][] map;
  Combat combat;

  AI (Combat combatState) {
    this.combat = combatState;
    this.map = combat.map;
  }


  void moveUnits() {
    /*
      deplacement unités
     */

    for (int x = 0; x < map.length; x++) {
      for (int y = 0; y < map[0].length; y++) {

        if (combat.isOccuped(x, y) && map[x][y].faction == ENY) {
          map[x][y].steps = 0;
          if (y == map[0].length - 1) {
            combat.pLives --;
            map[x][y] = null;
          }
        }
      }
    }


    for (int x = 0; x < map.length; x++) {
      for (int y = 0; y < map[0].length; y++) {

        if (combat.isOccuped(x, y) && map[x][y].faction == ENY && map[x][y].canMove()) {

          println("Ennemy unit in position ", x, y, "ready to move\n");

          if (y + 1 < map[0].length && !combat.isOccuped(x, y + 1)) {
            map[x][y + 1] = map[x][y];
            map[x][y + 1].steps += 1;
            map[x][y] = null;
          } else if (y + 1 < map[0].length && combat.isOccuped(x, y + 1)) {

            // l'unité est bloquée par une autre unité
            println("Ennemy", map[x][y].name, "is blocked in position", x, y + 1, "\n");
            map[x][y].stop();
          } else if (y + 1 >= map[0].length) {

            // l'unité atteint le camp adverse
            println("ennemy", map[x][y].name, " reached the bottom in position", x, y, "\n");
            map[x][y].stop();
          }
        }
      }
    }
  }

  //début des calculs
  /*
                Ordre des priorités d'action :
   
   Dernière défense 1 : vérifier si unités sur ligne 1 (avant-dernière), si oui placer unité forte (Admiral)
   Dernière défense 2 : vérifier si unités sur ligne 2 (avant-avant-dernière), si oui placer unité forte (Admiral)
   Attaque rapide : vérifier si une colonne est "vide" d'unités, aussi bien alliées qu'ennemies, si oui placer unité rapide  (Radio)
   Attaque basique : déterminer si une colonne présente moins d'unités que les autres, si oui placer au hasard une unité forte - unité basique (Gun - Clone)
   Dernière Chance : chercher une case vide dans les deux dernières lignes pour y placer une unité, si non, pas d'unités placées ce tour
   */

  boolean dd1() {
    for ( int x = 0; x < map.length; x ++ ) {
      if ( map[x][1] != null && map[x][1].faction == 0 ) {
        if ( map[x][0] == null) {


          this.combat.createUnit("Admiral", ENY, FRONT, x, 0);


          return true;
        } else {
          //return false;
        }
      }
      return false;
    }
    return false;
  }



  boolean dd2() {
    for ( int x = 0; x < map.length; x ++ ) {
      if ( map[x][2] != null && map[x][2].faction == 0 ) {
        if ( map[x][1] == null) {


          this.combat.createUnit("Admiral", ENY, FRONT, x, 0);


          return true;
        } else {
          //return false;
        }
        //return false;
      }
      //return false;
    }
    return false;
  }

  boolean ar() {
    for ( int x = 0; x < map.length; x ++) {
      for (int y = 0; y < map[x].length; y ++ ) {
        if ( map[x][y] != null && x < map.length - 1) {
          x = x + 1;
          y = 0;
        } else if (x ==  map.length - 1) {
          return false;
        } else if ( y == 5) {

          int hasard = int(random(0, 4));
          if (hasard <= 3) {
            println("tat");
            this.combat.createUnit("Gun", ENY, FRONT, x, 0);
            //placer Clone à map[x][0];
            y = 0;
            return true;
          } else {
            this.combat.createUnit("Radio", ENY, FRONT, x, 1);
            //placer Radio à map[x][0];
            y = 0;
            return true;
          }
        }
      }
    }
    return false;
  }

  boolean ab() {
    for ( int x = 0; x < map.length; x ++ ) {
      for (int y = 0; y < map[x].length; y ++ ) {
        int compter0 = 0, compter1 = 0, compter2 = 0, compter3 = 0;
        int choixA, choixB, choixC;
        int winA, winB, winC;

        if ( map[x][0] != null) {
          compter0 ++;
        }
        if ( map[x][1] != null) {
          compter1 ++;
        }
        if ( map[x][2] != null) {
          compter2 ++;
        }
        if ( map[x][3] != null) {
          compter3 ++;
        }

        if ( x == 3 && y == 5) {

          if ( compter0 >= compter1) {
            choixA = 1;
            winA = compter1;
          } else {
            choixA = 0;
            winA = compter0;
          }
          if ( compter2 >= compter3) {
            choixB = 3;
            winB = compter3;
          } else {
            choixB = 2;
            winB = compter2;
          }

          if ( winA > winB) {
            choixC = choixB;
          } else {
            choixC = choixA;
          }

          int hasard = int(random(1, 7));
          if (hasard == 1) {
            if ( map[x][1] == null) {
              this.combat.createUnit("Flame Gun", ENY, FRONT, x, 1);
              //placer Flame Gun à map[x][1];
              return true;
            } else if ( map[x][0] == null) {
              this.combat.createUnit("Flame Gun", ENY, FRONT, x, 0);
              //placer Flame Gun à map[x][0];
              return true;
            }
          }
          if (hasard == 2) {
            if ( map[x][1] == null) {
              this.combat.createUnit("Medic", ENY, FRONT, x, 1);
              //placer Medic à map[x][1];
              return true;
            } else if ( map[x][0] == null) {
              this.combat.createUnit("Medic", ENY, FRONT, x, 0);
              //placer Medic à map[x][0];
              return true;
            }
          }
          if (hasard == 3) {
            if ( map[x][1] == null) {
              this.combat.createUnit("Radio", ENY, FRONT, x, 1);
              //placer Radio à map[x][1];
              return true;
            } else if ( map[x][0] == null) {
              this.combat.createUnit("Radio", ENY, FRONT, x, 0);
              //placer Radio à map[x][0];
              return true;
            }
          }
          if (hasard == 4) {
            if ( map[x][1] == null) {
              this.combat.createUnit("Gun", ENY, FRONT, x, 1);
              //placer Gun à map[x][1];
              return true;
            } else if ( map[x][0] == null) {
              this.combat.createUnit("Gun", ENY, FRONT, x, 1);
              //placer Gun à map[x][0];
              return true;
            }
          } else if (hasard >= 5 && hasard <=7) {
            if ( map[x][1] == null) {
              this.combat.createUnit("Clone", ENY, FRONT, x, 1);
              //placer Clone à map[x][1];
              return true;
            } else if ( map[x][0] == null) {
              this.combat.createUnit("Clone", ENY, FRONT, x, 0);
              //placer Clone à map[x][0];
              return true;
            }
          }
        }
      }
    }
    return false;
  }

  boolean dc() {
    for ( int x = 0; x < 3; x ++) {
      for (int y = 0; y < 1; y ++ ) {

        if ( map[x][y] == null) {

          int hasard = int(random(1, 7));

          if (hasard == 1) {
            if ( map[x][1] == null) {
              this.combat.createUnit("Flame Gun", ENY, FRONT, x, 1);
              //placer Flame Gun à map[x][1];
              return true;
            } else if ( map[x][0] == null) {
              this.combat.createUnit("Flame Gun", ENY, FRONT, x, 0);
              //placer Flame Gun à map[x][0];
              return true;
            }
          } else if (hasard == 2) {
            if ( map[x][1] == null) {
              this.combat.createUnit("Medic", ENY, FRONT, x, 1);
              //placer Medic à map[x][1];
              return true;
            } else if ( map[x][0] == null) {
              this.combat.createUnit("Medic", ENY, FRONT, x, 0);
              //placer Medic à map[x][0];
              return true;
            }
          } else if (hasard == 3) {
            if ( map[x][1] == null) {
              this.combat.createUnit("Clone", ENY, FRONT, x, 1);
              //placer Clone à map[x][1];
              return true;
            } else if ( map[x][0] == null) {
              this.combat.createUnit("Clone", ENY, FRONT, x, 0);
              //placer Clone à map[x][0];
              return true;
            }
          } else if (hasard == 4) {
            if ( map[x][1] == null) {
              this.combat.createUnit("Gun", ENY, FRONT, x, 1);
              //placer Gun à map[x][1];
              return true;
            } else if ( map[x][0] == null) {
              this.combat.createUnit("Gun", ENY, FRONT, x, 0);
              //placer Gun à map[x][0];
              return true;
            }
          } else if (hasard >= 5 && hasard <=7) {
            if ( map[x][1] == null) {
              this.combat.createUnit("Radio", ENY, FRONT, x, 1);
              //placer Radio à map[x][1];
              return true;
            } else if ( map[x][0] == null) {
              this.combat.createUnit("Radio", ENY, FRONT, x, 0);
              //placer Radio à map[x][0];
              return true;
            }
          }
        }
      }
    }
    return false;
  }
}
