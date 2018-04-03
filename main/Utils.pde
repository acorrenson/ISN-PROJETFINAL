
/*
  Variables utiles
*/

int sqrSize = 64;

int cardWidth = 68;
int cardHeight = 120;

// Liste contenant toutes les images du jeu
ArrayList<PImage> assets = new ArrayList<PImage>();

/*
  Fonctions utiles
*/

void loadAssets() {
  
  // Charge toutes les images nécessaire au jeu
  
  println("> Loading assets ...");
  
  /* Les unités */
  
  // Grande image contenant toutes les images (ci après "sprite sheet")
  PImage unitsSS = loadImage("data/images/unitsSpritesheet.png");
  
  // Deux boucles for qui parcourent la sprite sheet pour extraire les images et les placer dans la list "assets"
  PImage tmp;
  for (int j = 0; j < unitsSS.height / 32; j ++ ) {
  
    for (int i = 0; i < unitsSS.width / 32; i ++) {
    
      tmp = unitsSS.get(i * 32, j * 32, 32, 32);
      assets.add( tmp );
    
    }
  
  }
  
  // Ajouter les autres images ici \|/
  
  println("< Success");

}

void loadUnits() {
  
  // Charge les différents types d'unités (JSON)
  
  println("> Loading JSON for units ...");  
  JSONUnits = loadJSONObject("data/units.json");
  println("< Success\n");
}

void enterState(State newState) {
  
  // Changement d'état
  
  actualState = newState;
  actualState.load();
}

boolean collide(int x, int y, int x2, int y2, int w, int h) {
  
  // Fonction basique, testant si deux éléments se supperposent (grace à leurs coordonnées et leurs tailles)
  
  if( x >= x2 && x <= (x2 + w) && y >= y2 && y <= (y2 + h)) {
    return true;
  }
  return false;
}

String getStateUrl(String fileName) {
  
  // Renvoie l'url d'un fichier contenant les données d'un State (JSON)
  return "data/states/" + fileName + ".json";
  
}

String getSaveUrl() {
  
  // Renvoie l'url du fichier de sauvegarde (JSON)
  
  return "data/save.json";
}

String getImageUrl(String fileName) {
  
  // Renvoie l'url d'un fichier image
  
  return "data/images/" + fileName + ".png";
}

String getSoundUrl(String fileName, String fileExt) {
  
  // Renvoie l'url d'un fichier son
  
  return "data/sounds/" + fileName + "." + fileExt;
}

int gai(String name, int faction, int side) {

  // Renvoie l'index du tableau contenant les images correspondant au nom d'une unité
  
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
