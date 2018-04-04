
/*
  Class combat dérivée de State
*/

class Combat extends State {

  /*
    map -------- : tableau (en 2D) contenant les unités présentent sur le plateau
    cards ------ : tableau contenant les cartes du joueurs
    selectedCard : index du tableau cards de la carte actuellement séléctionnée
  */
  
  Unit[][] map;
  Card[] cards;
  int selectedCard;

  Combat(String name) {
    
    // Constructeur de la classe
    
    super(name);
    this.map = new Unit[4][6];
    this.selectedCard = -1; // -1 = aucune carte séléctionnée
  }

  void load() {
    
    /*
      Charge les données du combat (ex : les cartes de l'IA ...)
      Génère les cartes du joueur
    */
    
    this.loadData();
    this.createCards();
  }

  boolean createUnit(String name, int side, int x, int y) {
    
    /*
      Simplifie la création d'une unité et renvoie true si l'unité est bien créée
    */
    
    if (!this.isOccuped(x, y)) {
      Unit NewUnit = new Unit(side, name); 
      this.map[x][y] = NewUnit;
      return true;
    } else {
      println(x, y, "est déjà occupée\n");
    }
    
    // Renvoie false si l'unité n'a pas été créée
    return false;
  }

  void createCards() {
    
    // FONCTION DE TEST !
    
    /*
      Génération des cartes du joueur
        - initialise le tableau contenant les cartes
        - le remplie grâce à une boucle for
    */
    
    this.cards = new Card[4];
    
    for(int i = 0; i < this.cards.length; i++) {
      int x = i * (cardWidth + cardWidth/5) + 100;
      int y = 500;
      this.cards[i] = new Card(x, y, "Clone");
    }
  }

  void renderCards() {
    
    /*
      Affichage des cartes
        - parcourt le tableau "cards"
        - appelle la méthode "render" de chaque carte
    */
    
    for(int i = 0; i < this.cards.length; i++) {
      if(this.cards[i] != null) this.cards[i].render();
    }
  }

  void renderUnit() {
    
    /*
      Affichage des untités
        - parcourt le tableau "map"
    */
    
    for (int i = 0; i < this.map.length; i ++) {
      for (int j = 0; j < this.map[0].length; j ++) {
        
        if(this.isOccuped(i, j)) {
          int[] newPos = this.returnPos(i, j);
          this.map[i][j].render(newPos[0], newPos[1]);
        }
        
      }
    }
  }

  void selectCard() {
    // selectionner une carte dans le tableau
    for(int i = 0; i < this.cards.length; i++) {
      Card c = this.cards[i];
      // si la carte existe et que le clique est dedans :
      if(c != null && collide(mouseX, mouseY, c.x, c.y, c.w, c.h)) {
        // stocker l'index de la carte séléctionnée
        this.selectedCard = i;
        // selectionner la carte
        c.select(); 
      }
    }
  }

  void unselectCard() {
    // lorsque la carte est déposée
    
    // newPos[0] <=> x
    // newPos[1] <=> y
    int[] newPos = this.returnIndex();
    
    // si la carte est lachée dans la zonne autorisée
    // essayer de créer une unité
    // si la création échoue, réinitiliser la carte
    int i = this.selectedCard;
    Card c = this.cards[i];

    if(newPos[0] >= 0 && this.createUnit(c.name, 0, newPos[0], newPos[1])) {
      this.cards[this.selectedCard] = null;
      this.selectedCard = -1; // aucune carte sélectionnée
    } else {
      this.cards[this.selectedCard].reset();
      this.selectedCard = -1; // aucune carte séléctionnée
    }
  }

  void update() {
    // boucle d'actualisation
    if(mousePressed && this.selectedCard == -1) {
      // si on clique et qu'aucune carte n'est déjà sélectionnée
      this.selectCard(); // séléctionner carte
    } else if (!mousePressed && this.selectedCard != -1) {
      // si on lache et qu'une carte est séléctionnée
      this.unselectCard(); // lacher la carte séléctionnée
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
    // retourne true si this.map[y][x] est
    // occupée par une unité
    if (this.map[x][y] == null) {
      return false;
    }
    return true;
  }

  int[] returnIndex() {
    // renvoie les indexs de la case ciblée avec la souris
    // si celle-ci pointe dans le plateau.

    // -1 = code d'erreur -> la souris ne pointe pas une case
    int[] result = {-1, -1};
    
    // on retire à la position de la souris
    // la valeur des bordures du tableaux de jeu (128px)
    int newX = mouseX - 128, newY = mouseY - 128;
    
    if ( newX >= 0 && newX <= 255 && newY >= 0 && newY <= 384 ) {
      // on convertit les coordonnées en pixel en index
      // dans le tableau this.map[][]
      result[0] = int( newX / sqrSize );
      result[1] = int( newY / sqrSize );
      
    }
    
    // renvoyer un tableau contenant les index
    // result[0] = coordonnée x
    // result[1] = coordonnée y
    return result; 
  }
  
  int[] returnPos(int x, int y) {
    // renvoie la position en pixel d'une case
    // dont on connait la position dans le tableau
    // this.map
    
    int[] result = new int[2];
    
    result[0] = 128 + sqrSize * x;
    result[1] = 128 + sqrSize * y;
    
    return result;
  }
}
