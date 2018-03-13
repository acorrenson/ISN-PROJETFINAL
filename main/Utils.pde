// changer d'état
void enterState(State newState) {
  actualState = newState;
  actualState.load();
}

// renvoie l'url complète d'un fichier json (/datas)
String getDataUrl(String fileName) {
  return "datas/" + fileName + ".json";
}

// renvoie l'url complète d'un fichier json (/saves)
String getSavesUrl(String fileName) {
  return "saves/" + fileName + ".json";
}