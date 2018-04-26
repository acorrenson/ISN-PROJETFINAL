
/*
  Class combat dérivée de State
*/

class Combat extends State {

  /*
    map -------- : tableau (en 2D) contenant les unités présentent sur le plateau
    cards ------ : tableau contenant les cartes du joueurs
    selectedCard : index du tableau cards de la carte actuellement séléctionnée (-1 pour aucune)
  */
  
  Unit[][] map;
  Card[] cards;
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
        - initialise le tableau contenant les cartes
    */
    
    this.cards = new Card[4];
    
    
    
    for(int i = 0; i < this.cards.length; i++) {
      int x = i * (cardWidth + cardWidth/5) + 100;
      int y = 500;
      this.cards[i] = new Card("Medic", x, y);
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
    
    for(int i = 0; i < this.cards.length; i++) {
      
      Card c = this.cards[i];
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
    Card c = this.cards[i];

    if(this.createUnit(c.name, ALLY, BACK, newPos[0], newPos[1])) {
      this.cards[this.selectedCard] = null;
      this.selectedCard = -1;
    } else {
      this.cards[this.selectedCard].reset();
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
