
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
  Card[] pCards;
  int selectedCard;
  int nbTour = 0; //compteur de tour

  boolean playerTour;
  boolean iaTour = false;
  boolean affrontement = false;

  boolean placementTime = true;

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
    this.playerTour = true;

    // EXEMPLE !
    // playMusic(0);
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
    
    int x, y = 500;
    
    for (int i = 0; i < nbCards; i ++ ) {
      
      int ran = int(random(this.availableUnits.length));
      String name = this.availableUnits[ran];
      x = i * (cardWidth + cardWidth/5) + 100;
    
      this.pCards[i] = new Card(name, x, y);
      
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
  
  void addACard(int i) {
    /*
      Ajoute une carte au tableau pCards    
        - Choisi une carte aléatoirement et l'ajoute aux cartes du joueur
    */
    
    int ran = int(random(this.availableUnits.length));
    String name = this.availableUnits[ran];
    int x = -1, y = 500;
    
    x = i * (cardWidth + cardWidth/5) + 100;    
    this.pCards[i] = new Card(name, x, y);
    
  }

  void renderUnit() {

    /*
      Affichage des untités
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

  boolean unselectCard() {
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

    if (this.createUnit(c.name, ALLY, BACK, newPos[0], newPos[1])) {
      this.addACard(i); // DEBUG
      this.selectedCard = -1;
      return true;
    } else {
      this.pCards[this.selectedCard].reset();
      this.selectedCard = -1;
      return false;
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




    if ( playerTour ) {                              //tour du joueur

        if (placementTime == true) {                   //placement de l'unité

        if (mousePressed && this.selectedCard == -1) {
          this.selectCard();
        } else if (!mousePressed && this.selectedCard != -1) {
          boolean cartePlaced;
          cartePlaced = this.unselectCard();

          if (cartePlaced == true) {

            placementTime = false;
          }
        }
      }

      if (placementTime == false) {                        //deplacement des unités alliées

        for ( int x = 0; x < map.length; x ++ ) {

          for (int y = 0; y < map[x].length; y ++ ) {

            if ( map[x][y] != null && map[x][y].faction == 0 ) {

              int step = map[x][y].step;
              for ( int i = (y - 1); i >= (y - step); i -- ) {

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

              nbTour = nbTour + 1;                              //on entame le tour suivant
              playerTour = false;                               //fin du tour du joueur
              affrontement = true;                              //debut de l'affrontement
            }
          }
        }
      }
    }


    if ( iaTour ) {                                                  //tour de l'ia

      if (placementTime == true) {                   //placement de l'unité
        //début des calculs
        /*
                Ordre des priorités d'action :
         
         Dernière défense 1 : vérifier si unités sur ligne 1 (avant-dernière), si oui placer unité forte (Admiral)
         Dernière défense 2 : vérifier si unités sur ligne 2 (avant-avant-dernière), si oui placer unité forte (Admiral)
         Attaque rapide : vérifier si une colonne est "vide" d'unités, aussi bien alliées qu'ennemies, si oui placer unité rapide  (Radio)
         Attaque basique : déterminer si une colonne présente moins d'unités que les autres, si oui placer au hasard une unité forte - unité basique (Gun - Clone)
         Dernière Chance : chercher une case vide dans les deux dernières lignes pour y placer une unité, si non, pas d'unités placées ce tour
         */

        //DD1 :
        for ( int x = 0; x < map.length  && placementTime == true; x ++ ) {
          if ( map[x][1] != null && map[x][1].faction == 0 ) {
            if ( map[x][0] == null) {
              this.createUnit("Admiral", ENY, FRONT, x, 0);
              //placer Admiral à map[x][0];
              placementTime = false;
              break;
            }
          }
        }

        //DD1 :
        for ( int x = 0; x < map.length && placementTime == true; x ++ ) {
          if ( map[x][2] != null && map[x][2].faction == 0 ) {
            if ( map[x][1] == null) {
              this.createUnit("Admiral", ENY, FRONT, x, 1);
              //placer Admiral à map[x][1];
              placementTime = false;
              break;
            }
          }
        }

        //AR
        for ( int x = 0; x < map.length && placementTime == true; x ++) {
          for (int y = 3; y < map[x].length && placementTime == true; y ++ ) {
            if ( map[x][y] != null) {
              x = x + 1;
              y = 3;
            }
            if ( y == 5) {
              int hasard = int(random(0, 4));
              if (hasard <= 3) {
                this.createUnit("Clone", ENY, FRONT, x, 0);
                //placer Clone à map[x][0];
                placementTime = false;
                break;
              } else {
                this.createUnit("Radio", ENY, FRONT, x, 1);
                //placer Radio à map[x][0];
                placementTime = false;
                break;
              }
            }
          }
        }

        //AB
        for ( int x = 3; x < map.length && placementTime == true; x ++ ) {
          for (int y = 3; y < map[x].length && placementTime == true; y ++ ) {
            int compter0 = 0, compter1 = 0, compter2 = 0, compter3 = 0;
            int choixA, choixB, choixC;
            int winA, winB, winC;

            if ( map[x][0] != null) {
              compter0 ++;
            }
            if ( map[x][1] != null) {
              compter1 ++;
            }
            if ( map[x][2] != null) {
              compter2 ++;
            }
            if ( map[x][3] != null) {
              compter3 ++;
            }

            if ( x == 3 && y == 5) {

              if ( compter0 >= compter1) {
                choixA = 1;
                winA = compter1;
              } else {
                choixA = 0;
                winA = compter0;
              }
              if ( compter2 >= compter3) {
                choixB = 3;
                winB = compter3;
              } else {
                choixB = 2;
                winB = compter2;
              }

              if ( winA > winB) {
                choixC = choixB;
              } else {
                choixC = choixA;
              }

              int hasard = int(random(1, 7));
              if (hasard == 1) {
                if ( map[x][1] == null) {
                  this.createUnit("Flame Gun", ENY, FRONT, x, 1);
                  //placer Flame Gun à map[x][1];
                  placementTime = false;
                } else if ( map[x][0] == null) {
                  this.createUnit("Flame Gun", ENY, FRONT, x, 0);
                  //placer Flame Gun à map[x][0];
                  placementTime = false;
                }
              }
              if (hasard == 2) {
                if ( map[x][1] == null) {
                  this.createUnit("Medic", ENY, FRONT, x, 1);
                  //placer Medic à map[x][1];
                  placementTime = false;
                } else if ( map[x][0] == null) {
                  this.createUnit("Medic", ENY, FRONT, x, 0);
                  //placer Medic à map[x][0];
                  placementTime = false;
                }
              }
              if (hasard == 3) {
                if ( map[x][1] == null) {
                  this.createUnit("Radio", ENY, FRONT, x, 1);
                  //placer Radio à map[x][1];
                  placementTime = false;
                } else if ( map[x][0] == null) {
                  this.createUnit("Radio", ENY, FRONT, x, 0);
                  //placer Radio à map[x][0];
                  placementTime = false;
                }
              }
              if (hasard == 4) {
                if ( map[x][1] == null) {
                  this.createUnit("Gun", ENY, FRONT, x, 1);
                  //placer Gun à map[x][1];
                  placementTime = false;
                } else if ( map[x][0] == null) {
                  this.createUnit("Gun", ENY, FRONT, x, 1);
                  //placer Gun à map[x][0];
                  placementTime = false;
                }
              } else if (hasard >= 5 && hasard <=7) {
                if ( map[x][1] == null) {
                  this.createUnit("Clone", ENY, FRONT, x, 1);
                  //placer Clone à map[x][1];
                  placementTime = false;
                } else if ( map[x][0] == null) {
                  this.createUnit("Clone", ENY, FRONT, x, 0);
                  //placer Clone à map[x][0];
                  placementTime = false;
                }
              }
            }
          }
        }



        //DC
        for ( int x = 0; x < 2 && placementTime == true; x ++) {
          for (int y = 0; y < 4 && placementTime == true; y ++ ) {

            if ( map[x][y] == null) {

              int hasard = int(random(1, 7));

              if (hasard == 1) {
                if ( map[x][1] == null) {
                  //placer Flame Gun à map[x][1];
                  placementTime = false;
                } else if ( map[x][0] == null) {
                  //placer Flame Gun à map[x][0];
                  placementTime = false;
                }
              }

              if (hasard == 2) {
                if ( map[x][1] == null) {
                  //placer Medic à map[x][1];
                  placementTime = false;
                } else if ( map[x][0] == null) {
                  //placer Medic à map[x][0];
                  placementTime = false;
                }
              }

              if (hasard == 3) {
                if ( map[x][1] == null) {
                  //placer Radio à map[x][1];
                  placementTime = false;
                } else if ( map[x][0] == null) {
                  //placer Radio à map[x][0];
                  placementTime = false;
                }
              }

              if (hasard == 4) {
                if ( map[x][1] == null) {
                  //placer Gun à map[x][1];
                  placementTime = false;
                } else if ( map[x][0] == null) {
                  //placer Gun à map[x][0];
                  placementTime = false;
                }
              } else if (hasard >= 5 && hasard <=7) {
                //placer Clone à map[x][1];
                placementTime = false;
              }
            }
          }
        }



        //fin placement
      }

      if (placementTime == false) {                   //déplacement des unités
        for ( int x = 0; x < map.length && iaTour == true; x ++ ) {

          for (int y = 0; y < map[x].length && iaTour == true; y ++ ) {

            if ( map[x][y] != null && map[x][y].faction == 1 ) {

              int step = map[x][y].step;

              for ( int i = (y + 1); i <= (y + step); i ++ ) {

                if ( i <= 5) {

                  if ( map[x][i] == null ) {

                    map[x][i] = map[x][y];
                    map[x][y] = null;
                  } else if ( map[x][i] != null ) {
                    println(x + " "+ y + " occuped");
                    nbTour = nbTour + 1;                              //on entame le tour suivant
                    iaTour = false;                                   //fin du tour du joueur
                    affrontement = true;                              //debut de l'affrontement
                    break;
                  }
                } else if ( i < 5 ) {

                  println("Bas atteint");
                  nbTour = nbTour + 1;                              //on entame le tour suivant
                  iaTour = false;                                   //fin du tour du joueur
                  affrontement = true;                              //debut de l'affrontement
                  break;
                }
              }
            }
          }
        }
      }
    }



    if (affrontement == true ) {                                          //affrontement

      for ( int x = 0; x < map.length; x ++ ) {

        for (int y = 1; y < map[x].length; y ++ ) {

          if ( map[x][y] != null && map[x][y].faction == 0 ) {


            if ( map[x][y-1] != null && map[x][y-1].faction == 1 ) {


              map[x][y].lives = map[x][y].lives - map[x][y-1].damages;
              map[x][y-1].lives = map[x][y-1].lives - map[x][y].damages;
            }
          }
        }
      }

      if (nbTour % 2 == 0) {                          //si le tour est pair, tour du joueur
        playerTour = true;
        iaTour = false;
        placementTime = true;                                    //le placement est à nouveau autorisé
        println("player");
        affrontement = false;
      } else {                                        //si impair, tour de l'ia
        playerTour = false;
        iaTour = true;
        placementTime = true;                                    //le placement est à nouveau autorisé
        println("ia");
        affrontement = false;
      }
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
}
