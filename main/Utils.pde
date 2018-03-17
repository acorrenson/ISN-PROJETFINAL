
/*
  Fonctions utiles
*/

void loadUnits() {
  // Charge les différents types d'unités (JSON)
  JSONUnits = loadJSONObject("data/units.json");
}

void createUnit(String name, int side) {
  // Simplifie la création d'une unité
  new Unit(JSONUnits.getJSONObject(name), side);
}

void enterState(State newState) {
  // Changement d'état
  actualState = newState;
  actualState.load();
}

void debugs() {

  // Nothing but chickens here ...
  createUnit("Matelot", 0);
  println(placedUnits.get(0).lives);

}

String getStateUrl(String fileName) {
  // Renvoie l'url d'un fichier contenant les données d'un State (JSON)
  return "data/states/" + fileName + ".json";
}

String getSaveUrl(String fileName) {
  // Renvoie l'url d'un fichier de sauvegarde (JSON)
  return "data/saves/" + fileName + ".json";
}

String getImageUrl(String fileName) {
  // Renvoie l'url d'un fichier image
  return "data/images/" + fileName + ".png";
}

String getSoundUrl(String fileName, String fileExt) {
  // Renvoie l'url d'un fichier son
  return "data/sounds/" + fileName + "." + fileExt;
}