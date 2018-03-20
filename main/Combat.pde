/*
  Class combat dérivée de State
 */

class Combat extends State {

  // Contenue du plateau
  Unit[][] map;

  Combat(String name) {
    super(name);
    this.map = new Unit[10][10];
  }

  void load() {

    // test de loadData()
    this.loadData();

    // test de setAString()
    this.setAString("test", "bye bye world");

    // test de createUnit en position 5 5
    createUnit("Matelot", 0, 5, 5);
    println("pv d'un matelot : ", this.map[5][5].lives);

    // test de isOccuped (TRUE)
    println(this.isOccuped(5, 5));
    createUnit("Matelot", 0, 5, 5);
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
    int[] result = new int[2];
    return result;
  }
}