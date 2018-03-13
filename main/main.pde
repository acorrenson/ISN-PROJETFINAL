
State actualState;

void setup() {
  size(480, 640);
  
  // nouveau state pour tester
  actualState = new combat_1();
  
  // définir l'état actuel
  enterState(actualState);
  
  // test de saveData();
  actualState.saveData();
}

void draw() {
  actualState.update();
  actualState.render();
}