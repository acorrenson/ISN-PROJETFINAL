// changer d'état
void enterState(State newState) {
  actualState = newState;
  actualState.load();
}

String getDataUrl(String fileName) {
  return "datas/" + fileName + ".json";
}

String getSavesUrl(String fileName) {
  return "saves/" + fileName + ".json";
}