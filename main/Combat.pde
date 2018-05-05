
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
  Card[] pCards, IACards;
  int selectedCard;
  
  int pLives, pMaxLives, IALives, IAMaxLives;
  
  boolean playerTour;
  boolean playerMoveTime;

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

    this.playerTour = false;
    this.playerMoveTime = false;

    createUnit("Radio", ENY, FRONT, 0, 0); // DEBUG
  }

  boolean createUnit(String name, int faction, int side, int x, int y) {

    /*
      Simplifie la création d'une unité et renvoie true si l'unité est bien créée
        - Test si la case visée est occupée
        - Ajoute une unité dans le tableau "map" aux index x et y
        - Passe le tour du joueur en ?

      FIX => playerTour = true, normal ?
    */

    if (x >= 0 && !this.isOccuped(x, y)) {
      Unit NewUnit = new Unit(name, faction, side); 
      this.map[x][y] = NewUnit;
      playerTour = true;
      return true;
    }
    return false;
  }
  
  void createCards() {

    /*
      Génération des cartes du joueur
        - recupère les unités disponibles
        - ajoute alléatoirement des cartes au tableau "pCards"

      FIX => Enlever le tableau IACards
    */

    this.availableUnits = this.data.getJSONArray("Cards").getStringArray();
    this.pCards = new Card[nbCards];
    this.IACards = new Card[nbCards];
    
    int x, y = 500;
    
    for (int i = 0; i < nbCards; i ++ ) {
      
      int ran = int(random(this.availableUnits.length));
      String name = this.availableUnits[ran];
      x = i * (cardWidth + cardWidth/5) + 100;
    
      this.pCards[i] = new Card(name, x, y);
      this.IACards[i] = new Card(name, -1, -1);
      
    }    
  }

  void renderCards() {

    /*
      Affiche les cartes
        - parcourt le tableau "pCards"
        - appelle la méthode render de chaque carte
    */

    for(int i = 0; i < this.pCards.length; i++) {
      if(this.pCards[i] != null) this.pCards[i].render();
    }
  }
  
  void addACard(int faction, int i) {

    /*
      Ajoute une carte au tableau "pCards"
        - Choisi une carte aléatoirement et l'ajoute au tableau "pCard"

      FIX => Faction plus nécessaire
    */
    
    int ran = int(random(this.availableUnits.length));
    String name = this.availableUnits[ran];
    int x = -1, y = 500;
    
    if ( faction == 0 ) {
      x = i * (cardWidth + cardWidth/5) + 100;    
      this.pCards[i] = new Card(name, x, y);
    } else {
      this.IACards[i] = new Card(name, x, y);
    }   
  }

  void renderUnit() {

    /*
      Affiche les untités
        - parcourt le tableau "map"
        - appelle la méthode "render" de chaque unité

      FIX => newPos, nom pas approprié
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

    /*
      Quand une carte est séléctionnée
        Si la carte existe et que le clic est par dessus
          - on stocke l'index de la carte séléctionnée
          - on appelle la méthode "select" de la carte
    */

    for(int i = 0; i < this.pCards.length; i++) {    

      Card c = this.pCards[i];
      if(c != null && collide(mouseX, mouseY, c.x, c.y, c.w, c.h)) {
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

      FIX => newPos nom pas approprié
    */

    int[] newPos = this.returnIndex();
    
    int i = this.selectedCard;
    Card c = this.pCards[i];

    if(this.createUnit(c.name, ALLY, BACK, newPos[0], newPos[1])) {
      this.addACard(0, i); // DEBUG !!
      this.selectedCard = -1;
    } else {
      this.pCards[this.selectedCard].reset();
      this.selectedCard = -1;
    }
  }

  void moveUnits() {

    /*
      Déplace les unités alliées
      FIX => ...
    */
    
    for (int x = 0; x < map.length; x++) {
      for (int y = 0; y < map[x].length; y++) {
        
        // si la case ciblé est un allié
        if (isOccuped(x, y) && map[x][y].faction == 0) {
          
          println(map[x][y].name + " can move\n");
          int step = map[x][y].step;
          
          // avancer au maximum
          for ( int i = (y - 1); i >= (y - step) ; i--) {
            if (i >= 0) {
              if (!isOccuped(x, i)) {
                map[x][i] = map[x][y];
                map[x][y] = null;
                break;
              }
            } else if (i < 0)  {
              println(map[x][y].name + " reached the top [" + x + ";" + y + "]\n");
              this.IALives --;
              map[x][y] = null;
              break;
            }
          }
          
        }
        
      }
    }

  }

  void update() {

    /*
      Actualisation de l'état
        Si détecte un clic de souris et qu'aucune carte n'est séléctionnée
          - Appelle la méthode "selectCard"
        Si la souris est relachée
          - Appelle la méthode "unselectCard"

      FIX => Séparer en plusieurs fonctions
    */

    if (playerTour) {
      
      if ( this.IALives == 0 ) {      
        println("Player winner\n");
      }

      /* TOUR DU JOUEUR */

      // Phase de placement de carte
      if(!playerMoveTime && mousePressed && this.selectedCard == -1) {
        
        this.selectCard();
      
      } else if (!mousePressed && this.selectedCard != -1) {
        
        this.unselectCard();

      } else if (playerMoveTime) {
        // phase de déplacement automatique
        moveUnits();
        playerMoveTime = false;
        playerTour = false;

        // => AFFRONTEMENT ICI
      }

    } else {

      /* TOUR DE L'IA*/

      // placement d'une carte
      if (!ennemy.dd1()) {
        println("next ia step 1");
      } else if (!ennemy.dd2()) {
        println("next ia step 2");
      }
      
      // déplacement unités
      ennemy.moveUnits();

      // => AFFRONTEMENT ICI
      
      playerTour = true;
    }

  }
  
  void renderLives() {
    
    /*
      Affiche les points de vie restant sous forme de barre
    */
  
    int x = (width / 2) - (assets[36].width / 2);
    int y = height - assets[36].height;
    
    int wP = int( (this.pLives * assets[36].width) / this.pMaxLives );
    int wIA = int( (this.IALives * assets[36].width) / this.IAMaxLives );
    
    noStroke();
    fill(#AD0000);
    rect(x, 0, wIA, 32);
    image(assets[36], x, 0);
    
    fill(#00AD07);
    rect(x, y, wP, 32);
    image(assets[36], x, y);  
  }
  
  void renderShips() {
  
    /*
      Affiche les vaisseaux        
    */
    
    int x = width - assets[37].width;
    int y = height - assets[37].height - 16;
    
    image(assets[37], x, 0);
    image(assets[37], x, y);
  }

  void render() {

    /*
      Affiche l'état
        - Affiche le plateau
        - Affiche les unités : "renderUnit"
        - Affiche les points de vies des vaisseaux : "renderLives"
        - Affiche les cartes : "renderCards"
    */

    background(0);
    image(assets[26], 128, 128);
    this.renderShips();
    this.renderUnit();
    this.renderLives();
    this.renderCards();
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

    if (k == 122) {
      if (playerTour && !playerMoveTime) {
        playerMoveTime = true;
      }
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

    int[] result = {-1, -1};
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
}
