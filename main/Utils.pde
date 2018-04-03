
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
  
  println("> Loading assets ...");
  
  PImage tmp;
  for (int i = 0; i <= 5; i ++) {
  
    tmp = loadImage("data/images/units/ally_" + str(i) + ".png");
    assets.add( tmp );
    tmp = loadImage("data/images/units/enemy_" + str(i) + ".png");
    assets.add( tmp );
    
  }
  
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

int getAssetIndex(String name) {

  // Renvoie l'index du tableau contenant les images correspondant au nom d'une unité
  
  if ( name.equals("Clone") ) {
    return 0;
  }
  
  else if ( name.equals("Gun") ) {
    return 1;
  }
  
  else if ( name.equals("Radio") ) {
    return 2;
  }
  
  else if ( name.equals("Medic") ) {
    return 3;
  }
  
  else if ( name.equals("Admiral") ) {
    return 4;
  }
  
  else if ( name.equals("Flame Gun") ) {
    return 5;
  }
  
  // Ajouter les nouvelles unités ici
  
  else {
    return -1;
  }
  
}
