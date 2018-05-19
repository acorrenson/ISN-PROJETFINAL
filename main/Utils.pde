
/*
  Variables utiles
    - pixelFont ------------ : (PFont)       Police de texte utilisé dans le jeu
    - sqrSize -------------- : (int)         taille d'une case du plateau
    - nbCards -------------- : (int)         nombre de cartes max
    - cardWidth (cardHeight) : (int)         tailles d'une carte
    - dispInfos ------------ : (boolean)     si l'on affiche les "infos" : les "infos" sont les statistiques d'une unité ou d'une carte qui est survolée par la souris
    - ALLY, ENY ------------ : (int)         index d'assets représentant les alliés/les ennemis
    - FRONT, BACK ---------- : (int)         index d'assets indiquant si l'image est de dos/de face
    - canPlaySound --------- : (boolean)     si on peut jouer les sons
    - FXVLM, MSCVLM -------- : (float)       volumes des effets/musiques
    - assets --------------- : (PImage[])    tableau contenant toutes les images du jeu
    - sounds --------------- : (SoundFile[]) tableau contenant tous les sons du jeu
*/

PFont pixelFont;

int sqrSize = 64;

int nbCards = 4;
int cardWidth = 68;
int cardHeight = 120;

boolean dispInfos = true;
int dispLives = 10, dispAtk = 0, dispStep = 0, dispUnit = 0;

int ALLY  = 0, ENY  = 1;
int FRONT = 0, BACK = 1;

boolean canPlaySound= true;
float FXVLM = 0.6, MSCVLM = 0.5;

PImage[] assets;
SoundFile[] sounds;

/*
  Fonctions utiles
*/

void loadAssets() {
  
  /*
    Charge toutes les images nécessaire au jeu
      - unitsSS : grande image contenant toutes les images (ci après "sprite sheet")
  */
  
  println("> Loading assets ...");
  
  /*
    Méthode pour récupérer le nombre de fichiers dans un dossier
      - folder - : désigne le chemin vers le dossier (data/images)
      - count -- : compte le nombre de fichiers (on ajoute 22 car le fichier unitsSpritesheet.png contient plusieurs images)
  */
  java.io.File folder = new java.io.File(dataPath("images"));
  String[] count = folder.list();
  assets = new PImage[count.length + 21];
  
  /* Les unités */
  
  PImage unitsSS = loadImage("data/images/unitsSpritesheet.png");
  
  // Deux boucles for qui parcourent la sprite sheet pour extraire les images et les placer dans la list "assets"
  PImage tmp;
  int step = 0;
  for (int j = 0; j < unitsSS.height / 32; j ++ ) {
  
    for (int i = 0; i < unitsSS.width / 32; i ++) {
    
      tmp = unitsSS.get(i * 32, j * 32, 32, 32);
      assets[step] = tmp;
      step ++;
    }
  
  }
  
  /* La pause */
  
  assets[24] = loadImage("data/images/pause.png");
  assets[25] = loadImage("data/images/hover.png");
  
  /* Le plateau */
  
  assets[26] = loadImage("data/images/pont.png");
  
  /* Le tuto */

  assets[27] = loadImage("data/images/slide1.png");
  assets[28] = loadImage("data/images/slide2.png");
  assets[29] = loadImage("data/images/slide3.png");
  assets[30] = loadImage("data/images/slide4.png");
  assets[31] = loadImage("data/images/slide5.png");
  assets[32] = loadImage("data/images/slide6.png");
  assets[33] = loadImage("data/images/slide7.png");
  assets[34] = loadImage("data/images/slide8.png");
  
  /* Les cartes */
  
  assets[35] = loadImage("data/images/card.png");
  
  /* Barre de vie */
  
  assets[36] = loadImage("data/images/liveSlot.png");
  assets[37] = loadImage("data/images/liveBarBorder.png");
  
  /* Vaisseaux */
  
  assets[38] = loadImage("data/images/ship.png");
  
  /* Scénario */
  
  assets[39] = loadImage("images/pageScenario.png");
  
  /* Fond */
  
  assets[40] = loadImage("images/space.png");
  
  /* Infos */
  
  assets[41] = loadImage("images/infos.png");
  
  /* Can Play Sounds */
  
  assets[42] = loadImage("images/sounds.png");

  // Ajouter les autres images ici \|/
  
  println("< Success\n");

}

void loadSounds() {
  
  println("> Loading sounds ...");

  java.io.File folder = new java.io.File(dataPath("sounds"));
  String[] count = folder.list();
  sounds = new SoundFile[count.length - 1];
  
  sounds[0] = new SoundFile(this, "sounds/theme.mp3");
  sounds[1] = new SoundFile(this, "sounds/click.mp3");
  
  println("< Success\n");
  
}

void loadUnits() {
  
  /*
    Charge les différents types d'unités (JSON)
  */
  
  println("> Loading JSON for units ...");  
  JSONUnits = loadJSONObject("data/units.json");
  println("< Success\n");
}

void enterState(State newState) {
  
  /*
    Change l'état actuel du jeu en modifiant "actualState" et en appelant la méthode "load" du nouvel état
  */
  
  actualState = newState;
  actualState.load();
}

void playSample(int id) {
  
  if ( canPlaySound ) {

    sounds[id].play();
    sounds[id].amp(FXVLM);
    int wait = ceil(sounds[id].duration() * 1000);
    delay(wait);
    sounds[id].stop();
  }
  
}

void stopMusic(int id) {
  
  if ( canPlaySound ) sounds[id].stop();
  
}

void stopMusic() {
  
  if ( canPlaySound ) {

    for (int i = 0; i < sounds.length; i ++ ) {
      sounds[i].stop();
    }
    
  }

}

void playMusic(int id) {
  
  if ( canPlaySound ) {

    stopMusic();
    sounds[id].loop();
    sounds[id].amp(MSCVLM);
    
  }

}

boolean collide(int x, int y, int x2, int y2, int w, int h) {
  
  /*
    Fonction basique, testant si deux éléments se supperposent (grace à leurs coordonnées et leurs tailles)
      Renvoie true si collision
  */
  
  if( x >= x2 && x <= (x2 + w) && y >= y2 && y <= (y2 + h)) {
    return true;
  }
  return false;
}

String getStateUrl(String fileName) {
  
  /*
    Renvoie l'url d'un fichier contenant les données d'un State (JSON)
  */
  
  return "data/states/" + fileName + ".json";  
}

String getSaveUrl() {
  
  /*
    Renvoie l'url du fichier de sauvegarde (JSON)
  */
  
  return "data/save.json";
}

int gai(String name, int faction, int side) {

  /*
    Renvoie l'index d'une image, contenue dans "assets", et determiné par le nom d'une unité
  */
  
  /*  
    - index = place de la première image d'une doublette ( une image de face, une image de dos )
    - side = si l'image est de face (0) ou de dos (1)
    - 12 * faction = si l'unité est ennemie (donc faction = 1) on se décale de 12, car il y a 12 images par camps  
  */
  
  int index;
  
  if ( name.equals("Clone") ) index = 0;
  
  else if ( name.equals("Gun") ) index = 2;
  
  else if ( name.equals("Radio") ) index = 4;
  
  else if ( name.equals("Medic") ) index = 6;
  
  else if ( name.equals("Admiral") ) index = 8;
  
  else if ( name.equals("Flame Gun") ) index = 10;
  
  else {
    index = -1;
  }
  
  return ( index + side + 12 * faction );
  
}

void screenshot() {
  save("data/images/screenshots/" + year() + "-" + day() + "-" + month() + "_" + hour() + "-" + minute() + "-" + second() + ".png");
}
