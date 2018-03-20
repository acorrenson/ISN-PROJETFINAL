/*
  Class combat dérivée de State
 */

class Combat extends State {

  // Contenue du plateau
  Unit[][] map;

  Combat(String name) {
    super(name);
    this.map = new Unit[4][6];
  }

  void load() {

    // Chargement des données relative au combat
    
  }

  void createUnit(String name, int side, int x, int y) {
    // Simplifie la création d'une unité
    if (!this.isOccuped(x, y)) {
      Unit NewUnit = new Unit(JSONUnits.getJSONObject(name), side); 
      this.map[y][x] = NewUnit;
    } else {
      println(x, y, "est déjà occupée\n");
    }
  }

  void update() {
    // boucle d'actualisation
  }

  void render() {
    // affichage (60 fps)
    background(0);
  }

  boolean isOccuped(int x, int y) {
    if (this.map[y][x] == null) {
      return false;
    }
    return true;
  }

  int[] returnIndex() {
  
    int[] result = {-1, -1};
    
    int newX = mouseX - 128, newY = mouseY - 128;
    
    if ( newX >= 0 && newX <= 255 && newY >= 0 && newY <= 384 ) {
    
      result[0] = int( newX / sqrSize );
      result[1] = int( newY / sqrSize );
      
    }
    
    return result;    
  
  }
}