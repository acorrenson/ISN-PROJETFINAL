
/*
  Class combat dérivée de State
 */

class Combat extends State {

  /*
    map ------------- : tableau (en 2D) contenant les unités présentent sur le plateau
   availableUnits -- : tableau contenant les unités possibles
   pCards ---------- : tableau contenant les cartes du joueur
   IACards --------- : tableau contenant les cartes de l'IA
   selectedCard ---- : index du tableau cards de la carte actuellement séléctionnée (-1 pour aucune)
   pLives, IALives - : points de vie restant aux vaiseaux (pMaxLives, IAMaxLives : points de vie max) 
   */

  AI ennemy;
  Unit[][] map;

  String[] availableUnits;
  Card[] pCards;
  int selectedCard;

  int pLives, pMaxLives, IALives, IAMaxLives;

  boolean playerTour, playerMoveTime, playerCanPose;

  Button validTurn, pause;
  boolean wait;

  Combat(String name) {

    // Constructeur de la classe

    super(name);
    this.map = new Unit[4][6];
    this.selectedCard = -1;
    this.ennemy = new AI(this);
  }

  void load() {

    /*
      - Charge les données du combat (JSON, ex : les cartes de l'IA ...)
     - Appelle la fonction "createCards"
     - Récupère les points de vie
     - Initialiste les variables pour les tours
     */

    this.loadData();
    this.createCards();

    this.pMaxLives = this.data.getInt("Player Lives");
    this.pLives = this.pMaxLives;
    this.IAMaxLives = this.data.getInt("IA Lives");
    this.IALives = this.IAMaxLives;

    this.playerTour = true;
    this.playerMoveTime = false;
    this.playerCanPose = true;

    // Bouton de validation du tour
    this.validTurn = new Button("valider", 10, 400, 100, 30);
    this.pause = new Button("pause", 0, 0, 100, 25);
    this.wait = false;

  }

  /* UNITS */

  boolean createUnit(String name, int faction, int side, int x, int y) {

    /*
      Simplifie la création d'une unité et renvoie true si l'unité est bien créée
     - Test si la case visée est occupée
     - Ajoute une unité dans le tableau "map" aux index x et y
    */
    
    if (faction == ALLY && y < 4) { return false; }

    if (x >= 0 && !this.isOccuped(x, y)) {
      Unit NewUnit = new Unit(name, faction, side); 
      this.map[x][y] = NewUnit;
      return true;
    }
    return false;
  }

  void deleteUnits(int x, int y) {
    map[x][y] = null;
  }

  void renderUnit() {

    /*
      Affiche les untités
     - parcourt le tableau "map"
     - appelle la méthode "render" de chaque unité
     */

    for (int i = 0; i < this.map.length; i ++) {
      for (int j = 0; j < this.map[0].length; j ++) {

        if (this.isOccuped(i, j)) {
          int[] newPos = this.returnPos(i, j);
          this.map[i][j].render(newPos[0], newPos[1]);
        }
      }
    }
  }

  void moveUnits() {

    /*
      Déplace les unités alliées
     */

    // remettre tous les compteurs de pas à 0
    // les unités ayant atteints le camps adverse attaquent 
    for (int x = map.length - 1; x >= 0; x--) {
      for (int y = map[0].length - 1; y >= 0; y--) {
        if (isOccuped(x, y) && map[x][y].faction == 0) {
          // compteurs à 0
          map[x][y].steps = 0;
          // attaque du camp adverse
          if (y == 0) {
            IALives --;
            map[x][y] = null;
          }
        }
      }
    }

    // déplacer toutes les unités alliées
    for (int x = map.length - 1; x >= 0; x--) {
      for (int y = map[0].length - 1; y >= 0; y--) {
        if (isOccuped(x, y) && map[x][y].faction == 0 && map[x][y].canMove()) {

          println("Ally unit in position ", x, y, "ready to move \n");

          if ((y - 1) >= 0 && !isOccuped(x, y - 1)) {

            // déplacer l'unité de 1
            map[x][y - 1] = map[x][y];
            map[x][y].steps += 1;
            map[x][y] = null;
          } else if ((y - 1) >= 0 && isOccuped(x, y - 1)) {

            // l'unité est bloquée par une autre unité
            println("Ally", map[x][y].name, "is blocked in position", x, y-1, "\n");
            map[x][y].stop();
          } else if (y - 1 < 0) {

            // l'unité atteint le camp adverse
            println("Ally", map[x][y].name + " reached the top in position", x, y, "\n");
            map[x][y].stop();
          }
        }
      }
    }
  }

  void checkLives() {
    for ( int x = 0; x < map.length; x ++ ) {
      for (int y = 0; y < map[x].length; y ++ ) {


        if ( map[x][y] != null && map[x][y].lives <= 0 ) {
          println("mort" + " " + map[x][y].lives);
          deleteUnits(x, y);
        }
      }
    }
  }

  void fight() {
    for ( int x = 0; x < map.length; x ++ ) {

      for (int y = 1; y < map[x].length; y ++ ) {

        if ( map[x][y] != null && map[x][y].faction == 0 ) {


          if ( map[x][y-1] != null && map[x][y-1].faction == 1 ) {

            println(map[x][y-1].lives);
            map[x][y].lives = map[x][y].lives - map[x][y-1].damages;
            map[x][y-1].lives = map[x][y-1].lives - map[x][y].damages;
          }
        }
      }
    }

  }

  void checkValidTurn() {
    if (this.playerTour && !this.playerMoveTime && this.validTurn.hover()) {
      this.playerMoveTime = true;
    }
  }

  /* CARDS */

  void createCards() {

    /*
      Génération des cartes du joueur
     - recupère les unités disponibles
     - ajoute alléatoirement des cartes au tableau "pCards"
     */

    this.availableUnits = this.data.getJSONArray("Cards").getStringArray();
    this.pCards = new Card[nbCards];

    int x, y = 500;

    for (int i = 0; i < nbCards; i ++ ) {

      int ran = int(random(this.availableUnits.length));
      String name = this.availableUnits[ran];
      x = i * (cardWidth + cardWidth/5) + 100;

      this.pCards[i] = new Card(name, x, y);
    }
  }

  void addACard(int i) {

    /*
      Ajoute une carte au tableau "pCards"
     - Choisi une carte aléatoirement et l'ajoute au tableau "pCard"
     */

    int ran = int(random(this.availableUnits.length));
    String name = this.availableUnits[ran];
    int x = -1, y = 500;

    x = i * (cardWidth + cardWidth/5) + 100;    
    this.pCards[i] = new Card(name, x, y);
  }

  void selectCard() {

    /*
      Quand une carte est séléctionnée
     Si la carte existe et que le clic est par dessus
     - on stocke l'index de la carte séléctionnée
     - on appelle la méthode "select" de la carte
     */

    for (int i = 0; i < this.pCards.length; i++) {    

      Card c = this.pCards[i];
      if (c != null && collide(mouseX, mouseY, c.x, c.y, c.w, c.h)) {
        this.selectedCard = i;
        c.select();
      }
    }
  }

  void unselectCard() {

    /*
      Quand une carte est lachée
     - Récupère les index x et y de la case survolée et le stock dans un tableau
     - Récupère l'index de la carte
     Si la carte est sur le plateau
     - Appelle la méthode "createUnit"
     - Enlève la carte de "cards" et réinitialise "selectedCard"
     Sinon, replace la carte à son point d'origine
     */

    int[] newPos = this.returnIndex();

    int i = this.selectedCard;
    Card c = this.pCards[i];

    if (this.createUnit(c.name, ALLY, BACK, newPos[0], newPos[1])) {
      this.addACard(i);
      this.selectedCard = -1;
      this.playerCanPose = false;
    } else {
      this.pCards[this.selectedCard].reset();
      this.selectedCard = -1;
    }
  }

  void renderCards() {

    /*
      Affiche les cartes
     - parcourt le tableau "pCards"
     - appelle la méthode render de chaque carte
     */

    for (int i = 0; i < this.pCards.length; i++) {
      if (this.pCards[i] != null) this.pCards[i].render(playerCanPose);
    }
  }

  /* RENDERS */

  void renderLives() {

    /*
      Affiche les points de vie restant sous forme de barre
     */
     
    int wP = int( this.pLives * assets[36].width );
    int wIA = int( this.IALives * assets[36].width );
    int wMaxP = int( this.pMaxLives * assets[36].width );
    int wMaxIA = int( this.IAMaxLives * assets[36].width );
     
    int yP = height - assets[36].height;    
    int xP = int( (width / 2) - wMaxP / 2 );
    int xIA = int( (width / 2) - wMaxIA / 2);
    
    if ( wP < 0 ) wP = 0;
    if ( wIA < 0 ) wIA = 0;

    noStroke();
    fill(#AD0000);
    rect(xIA, 0, wIA, 32);

    fill(#00AD07);
    rect(xP, yP, wP, 32);
    
    for (int i = 0; i < this.pMaxLives; i ++) {
      image(assets[36], (i * 32) + xP, yP);
    }
    for (int i = 0; i < this.IAMaxLives; i ++) {
      image(assets[36], (i * 32) + xIA, 0);
    }
    
    image(assets[37].get(0,0, 13, 32), xP - assets[37].width / 2, yP);
    image(assets[37].get(0,0, 13, 32), xIA - assets[37].width / 2, 0);
    image(assets[37].get(13,0, 26, 32), xP + wMaxP, yP);
    image(assets[37].get(13,0, 26, 32), xIA + wMaxIA, 0);
  }

  void renderShips() {

    /*
      Affiche les vaisseaux        
     */

    int x = width - assets[38].width;
    int y = height - assets[38].height - 16;

    image(assets[38], x, 0);
    image(assets[38], x, y);
  }

  /* FUNCTIONS */

  void mousePressed() {
    /*
      Capture les cliques souris
    */

    // attendre une clique sur le bouton Valider Tour
    this.checkValidTurn();
    if ( this.pause.hover() ) enterState( new Pause(actualState) );
  }

  void keyDown(int k) {

    /*
      Capture les événement clavier
     - ESC - : Met le jeu en pause
     - Z --- : DEBUG, Passe le tour du joueur (122)
     */

    if (k == 27) {
      enterState( new Pause(actualState) );
    }

    else if (k == 122) {
      if (playerTour && !playerMoveTime) {
        playerMoveTime = true;
      }
    }
    
    else if (k == 101) {
      this.pLives -= 1;
    }
    
    else {
      println(k);
    }
  }

  boolean isOccuped(int x, int y) {

    /*
      Renvoie true si la case map[x][y] est occupée
     */

    if (this.map[x][y] == null) {
      return false;
    }
    return true;
  }

  int[] returnIndex() {

    /*
      Renvoie les index x et y de la case survolée par la souris sous forme d'un tableau
     Renvoie {-1;-1} si la souris est en dehors du tableau
     
     Pour calculer l'index
     On retire à la position de la souris la position du tableau (128 px en x et y)
     On convertit les coordonnées en index du tableau "map"
     */

    int[] result = {
      -1, -1
    };
    int newX = mouseX - 128, newY = mouseY - 128;

    if ( newX >= 0 && newX <= 255 && newY >= 0 && newY <= 384 ) {
      result[0] = int( newX / sqrSize );
      result[1] = int( newY / sqrSize );
    }

    return result;
  }

  int[] returnPos(int x, int y) {

    /*
      Renvoie un tableau avec la position (en px) d'une case de "map" à l'aide de ses index
     */

    int[] result = new int[2];

    result[0] = 128 + sqrSize * x;
    result[1] = 128 + sqrSize * y;

    return result;
  }

  /* UPDATE & RENDER */

  void update() {
    /*
      Actualisation de l'état
     Si détecte un clic de souris et qu'aucune carte n'est séléctionnée
     - Appelle la méthode "selectCard"
     Si la souris est relachée
     - Appelle la méthode "unselectCard"
     */

    if (playerTour) {
      
      if ( this.IALives <= 0 ) {
        enterState( new EndScreen(true) );
      } else if ( this.pLives <= 0 ) {
        enterState( new EndScreen(false) );
      }

      /* TOUR DU JOUEUR */

      // Phase de placement de carte
      if (!playerMoveTime && playerCanPose && mousePressed && this.selectedCard == -1) {

        this.selectCard();
      } else if (!mousePressed && this.selectedCard != -1) {

        this.unselectCard();
      } else if (playerMoveTime) {
        // phase de déplacement automatique
        moveUnits();
        playerMoveTime = false;
        playerTour = false;

        // => AFFRONTEMENT ICI
        fight();
        checkLives();
      }
    } else {

      /* TOUR DE L'IA*/
      delay(300);

      // placement d'une carte
      if (ennemy.dd1()) {
        println("next ia step 1");
      } else if (ennemy.dd2()) {
        println("next ia step 2");
      } else if (ennemy.ar()) {
        println("next ia step 3");
      } else if (ennemy.ab()) {
        println("next ia step 4");
      } else if (ennemy.dc()) {
        println("next ia step 5");
      }

      // déplacement unités
      ennemy.moveUnits();

      // => AFFRONTEMENT ICI

      playerTour = true;
      playerCanPose = true;
    }
  }

  void render() {
    /*
      Affiche l'état
     - Affiche le plateau
     - Affiche les unités : "renderUnit"
     - Affiche les points de vies des vaisseaux : "renderLives"
     - Affiche les cartes : "renderCards"
    */
    background(assets[40]);
    image(assets[26], 128, 128);
    this.renderShips();
    this.renderUnit();
    this.renderLives();
    this.renderCards();
    textSize(5);
    this.validTurn.render(255, 0);
    textSize(10);
    this.pause.render(0, 255);
    if ( dispInfos ) {
      fill(0, 0, 0, 150);
      stroke(255);
      strokeWeight(1);
      rectMode(CORNER);
      int w = 2 * width / 4, x = width - w, y = height / 4;
      rect(x, y, w, 60);
      fill(255);
      textAlign(LEFT, TOP);
      textSize(10);
      text(infos, x + 5, y + 5, w, 60);
      image(assets[dispUnit], width - 32, y + 5);
    }
  }
}
