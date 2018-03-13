
void enterState(State newState) {

  actualState = newState;
  
  actualState.load();

}
