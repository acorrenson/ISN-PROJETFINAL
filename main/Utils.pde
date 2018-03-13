// changer d'état
void enterState(State newState) {
  actualState = newState;
  actualState.load();
}