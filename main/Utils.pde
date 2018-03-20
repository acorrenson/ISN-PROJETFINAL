
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
