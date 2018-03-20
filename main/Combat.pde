/*
  Class combat dérivée de State
  */

  class Combat extends State {

  // Contenue du plateau
  Unit[][] map;
  Card[] cards;
  // boolean cardSelected;

  Combat(String name) {
    super(name);
    this.map = new Unit[6][4];
    this.cards = new Card[4];
    // this.cardSelected = false;
  }

  void load() {

    // test de loadData()
    this.loadData();

    // test de setAString()
    this.setAString("test", "bye bye world");

    // test de createUnit en position 5 5
    this.createUnit("Matelot", 0, 0, 0);
    println("pv d'un matelot : ", this.map[0][0].lives);

    // test de isOccuped (TRUE)
    println(this.isOccuped(0, 0));
    createUnit("Matelot", 0, 0, 0);

    // test des cartes
    this.createCards();

  }

  boolean createUnit(String name, int side, int x, int y) {
    // Simplifie la création d'une unité
    if (!this.isOccuped(x, y)) {
      Unit NewUnit = new Unit(JSONUnits.getJSONObject(name), side); 
      this.map[y][x] = NewUnit;
      return true;
    } else {
      println(x, y, "est déjà occupée\n");
    }
    return false;
  }

  void createCards() {
    for(int i = 0; i < this.cards.length; i++) {
      this.cards[i] = new Card(i * 60 + 50, 500, 0);
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

  void renderUnit() {
    for (int i = 0; i < this.map.length; ++i) {
      for (int j = 0; j < this.map[0].length; ++j) {
        if(this.isOccuped(j, i)) {
          fill(255, 0, 0);
          rect(128 + j * 64, 128  + i * 64, 64, 64);
        }
      }
    }
  }

  void placeCards() {
    // tester le placement des cartes
    for(int i = 0; i < this.cards.length; i++) {
      if(this.cards[i] != null) {
        this.cards[i].place(128, 128, 256, 384);
        int x = mouseX;
        int y = mouseY;
        if(this.cards[i].placed) {
          int newX = (int) x/64 - 2;
          int newY = (int) y/64 - 2;
          // créer la nouvelle unité
          boolean success = this.createUnit("Matelot", 0, newX, newY);
          // détruire la carte ou la reset
          if(success) {
            this.cards[i] = null;
          } else {
            this.cards[i].reset();
          }
        }
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
    stroke(255);
    noFill();
    rect(128, 128, 256, 384);
    this.renderUnit();
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