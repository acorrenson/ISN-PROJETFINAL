
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
    for (int x = map.length - 1; x >= 0; x--) {
      for (int y = map[x].length - 1; y >= 0; y--) {
        if (combat.isOccuped(x, y) && map[x][y].faction == ENY) {
          // déplacer l'unité
          int step = map[x][y].step;

          for (int i = (y + 1); i <= (y + step); i++)  {
            if (i <= 5) {
              if (!combat.isOccuped(x, i)) {
                map[x][i] = map[x][y];
                map[x][y] = null;
              } else {
                println(x + " "+ y + " occuped (adv)");
                break;
              }
            } else if (i > 5) {
              println("Bas atteint (adv)");
              break;
            }
          }
        }
      }
    }
  }

  boolean dd1() {
    return false;
  }

  boolean dd2() {
    return true;
  }
}
