
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

  boolean dd1() {
    return false;
  }

  boolean dd2() {
    return true;
  }
}
