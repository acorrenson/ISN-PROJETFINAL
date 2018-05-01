
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
  */
  
  Unit[][] map;
  
  String[] availableUnits;
  Card[] pCards, IACards;
  int selectedCard;
  
  boolean playerTour;

  Combat(String name) {
    
    // Constructeur de la classe
    
    super(name);
    this.map = new Unit[4][6];
    this.selectedCard = -1;
  }

  void load() {
    
    /*
      Charge les données du combat (ex : les cartes de l'IA ...)
      Génère les cartes du joueur
    */
    
    this.loadData();
    this.createCards();
    this.playerTour = false;
    
    // EXEMPLE !
    playMusic(0);
  }

  boolean createUnit(String name, int faction, int side, int x, int y) {
    
    /*
      Simplifie la création d'une unité et renvoie true si l'unité est bien créée
    */
    
    if (x >= 0 && !this.isOccuped(x, y)) {
      Unit NewUnit = new Unit(name, faction, side); 
      this.map[x][y] = NewUnit;
      playerTour = true;
      return true;
    } else {
      println("Can't place unit at " + x + " " + y + "\n");
    }
    
    return false;
  }
  
  void createCards() {
    
    /*
      Génération des cartes du joueur
        - recupère les unités disponibles
        - ajoute alléatoirement des cartes aux tableaux pCards et IACards
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
      Affichage des cartes
        - parcourt le tableau pCards
        - appelle la méthode render de chaque carte
    */
    
    for(int i = 0; i < this.pCards.length; i++) {
      if(this.pCards[i] != null) this.pCards[i].render();
    }
  }
  
  void addACard(int faction, int i) {
    /*
      Ajoute une carte au tableau pCards    
        - Choisi une carte aléatoirement et l'ajoute au tableau correspondant à faction (0 = pCards ; 1 = IACards)
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
      Affichage des untités
        - parcourt le tableau "map"
        - appelle la méthode "render" de chaque unité
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
        - Récupère l'index x (y) de la case survolée et le stock dans un tableau
        - Récupère l'index de la carte
        Si la carte est sur le plateau
          - Appelle la méthode "createUnit"
          - Enlève la carte de "cards" et réinitialise "selectedCard"
        Sinon, replace la carte à son point d'origine
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

  void update() {
    
    /*
      Actualisation de l'état
        Si détecte un clic de souris et qu'aucune carte n'est séléctionnée
          - Appelle la méthode "selectCard"
        Si la souris est relachée
          - Appelle la méthode "unselectCard"
    */
    
    if ( playerTour ) {
    
      for ( int x = 0; x < map.length; x ++ ) {
      
        for (int y = 0; y < map[x].length; y ++ ) {
          
          if ( map[x][y] != null && map[x][y].faction == 0 ) {
            
            int step = map[x][y].step;
            for ( int i = (y - 1); i >= (y - step) ; i -- ) {
              println(i);
              
              if ( i >= 0) {

                if ( map[x][i] == null ) {

                  map[x][i] = map[x][y];
                  map[x][y] = null;
                  
                } else if ( map[x][i] != null ) {
                  println(x + " "+ y + " occuped");
                  break;
                }
              
              } else if ( i < 0 ) {
              
                println("Haut atteint");
                break;
              }
            }
            
            playerTour = false;

          }
        
        }
      
      }
    
    }
    
    
    if(mousePressed && this.selectedCard == -1) {
      this.selectCard();
    } else if (!mousePressed && this.selectedCard != -1) {
      this.unselectCard();
    }
    
  }

  void render() {
    /*
      Affichage de l'état
          - LISTE DES FONCTIONS APPELLEES
    */
    
    background(0);
    image(assets[26], 128, 128);
    this.renderUnit();
    this.renderCards();
  }
  
  void keyDown(int k) {
    
    if (k == 27) {
      enterState( new Pause(actualState) );
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
      Renvoie l'index x (y) de la case survolée pars la souris sous forme d'un tableau
      Renvoie {-1;-1} si la souris est en dehors du tableau
      
      Pour calculer l'index
        On retire à la position de la souris la position du tableau (128 px en x et y)
        On convertit les coordonnées (en px) en index du tableau "map"
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
