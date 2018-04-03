
/*
  Variables utiles
*/

int sqrSize = 64;

int cardWidth = 68;
int cardHeight = 120;

// Liste contenant toutes les images du jeu
ArrayList<PImage> assets;

/*
  Fonctions utiles
*/

void loadUnits() {
  // Charge les différents types d'unités (JSON)
  JSONUnits = loadJSONObject("data/units.json");
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

  // Renvoie l'index du tableau assets correspondant au nom d'une unité
  
  if ( name.equals("Matelot") ) {
    return 0;
  }
  
  else if ( name.equals("Cuisinier") ) {
    return 1;
  }
  
  // Ajouter les nouvelles unités ici
  
  else {
    return -1;
  }
  
}
