/*
  Class combat dérivée de State
  */

  class Combat extends State {

  // Contenue du plateau
  Unit[][] map;
  Card[] cards;
  int selectedCard;

  Combat(String name) {
    super(name);
    this.map = new Unit[6][4];
    this.cards = new Card[4];
    this.selectedCard = -1;
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
    // remplire les cartes
    for(int i = 0; i < this.cards.length; i++) {
      this.cards[i] = new Card(i * 60 + 50, 500, 0);
    }
  }

  void renderCards() {
    // afficher les cartes
    for(int i = 0; i < this.cards.length; i++) {
      if(this.cards[i] != null) this.cards[i].render();
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

  void selectCard() {
    for(int i = 0; i < this.cards.length; i++) {
      Card c = this.cards[i];
      if(c != null && collide(mouseX, mouseY, c.x, c.y, c.w, c.h)) {
        this.selectedCard = i;
        c.select();
      }
    }
  }

  void unselectCard() {
    int newX = (int) mouseX/64 - 2;
    int newY = (int) mouseY/64 - 2;

    if(newX >= 0 && newX < 4 && newY >= 0 && newY < 6 && this.createUnit("Matelot", 0, newX, newY)) {
      this.cards[this.selectedCard] = null;
      this.selectedCard = -1;
    } else {
      this.cards[this.selectedCard].reset();
      this.selectedCard = -1;
    }
  }

  void update() {
    // boucle d'actualisation
    if(mousePressed && this.selectedCard == -1) {
      this.selectCard();
    } else if (!mousePressed && this.selectedCard != -1) {
      this.unselectCard();
    }
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