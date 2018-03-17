
State actualState;

void setup() {
  size(480, 640);
  
  // Loads
  loadUnits();
  
  // Nouveau State
  actualState = new Combat("combat_1");
  
  // Définir le State actuel
  enterState(actualState);
  
  // Test de saveData();
  actualState.saveData();
}

void draw() {
  
  actualState.update();
  actualState.render();
  
}