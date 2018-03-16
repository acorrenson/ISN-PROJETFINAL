
State actualState;

void setup() {
  size(480, 640);
  
  // Nouveau State
  actualState = new combat_1();
  
  // Définir le State actuel
  enterState(actualState);
  
  // Test de saveData();
  actualState.saveData();
}

void draw() {
  
  actualState.update();
  actualState.render();
  
}