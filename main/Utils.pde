
/*
  Fonctions utiles
*/

void enterState(State newState) {
  // Changement d'état
  actualState = newState;
  actualState.load();
}

String getDataUrl(String fileName) {
  // Renvoie l'url complète d'un fichier json (/datas)
  return "datas/" + fileName + ".json";
}

String getSavesUrl(String fileName) {
  // Renvoie l'url complète d'un fichier json (/saves)
  return "saves/" + fileName + ".json";
}