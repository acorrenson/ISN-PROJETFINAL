/*
  Class combat dérivée de State
 */

class Combat extends State {

  // Contenue du plateau
  Unit[][] map;
  Card[] cards;

  Combat(String name) {
    super(name);
    this.map = new Unit[10][10];
    this.cards = new Card[4];
  }

  void load() {

    // test de loadData()
    this.loadData();

    // test de setAString()
    this.setAString("test", "bye bye world");

    // test de createUnit en position 5 5
    this.createUnit("Matelot", 0, 5, 5);
    println("pv d'un matelot : ", this.map[5][5].lives);

    // test de isOccuped (TRUE)
    println(this.isOccuped(5, 5));
    createUnit("Matelot", 0, 5, 5);

    // test des cartes
    this.createCards();

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

  void createCards() {
    for(int i = 0; i < this.cards.length; i++) {
      this.cards[i] = new Card(i * 60 + 50, 200, 0);
    }
  }

  void renderCards() {
    // afficher les cartes
    for(int i = 0; i < this.cards.length; i++) {
      if(this.cards[i] != null) {
        this.cards[i].render();
      }
    }
  }

  void moveCards() {
    // déplacer les cartes
    for(int i = 0; i < this.cards.length; i++) {
      if(this.cards[i] != null) {
        this.cards[i].move();
      }
    }
  }

  void placeCards() {
    // tester le placement des cartes
    for(int i = 0; i < this.cards.length; i++) {
      if(this.cards[i] != null) {
        this.cards[i].place(0, 0, height, width);
      }
    }
  }

  void update() {
    // boucle d'actualisation
    this.moveCards();
    this.placeCards();
  }

  void render() {
    // affichage (60 fps)
    background(0);
    this.renderCards();
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