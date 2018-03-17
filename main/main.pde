
State actualState;

void setup() {
  size(480, 640);
  
  // Loads
  loadUnits();
  
  // Nouveau State
  actualState = new combat();
  
  // Définir le State actuel
  enterState(actualState);
  
  // Test de saveData();
  actualState.saveData();  
  
  // Affichage d'informations de debug
  debugs();
}

void draw() {
  
  actualState.update();
  actualState.render();
  
}