
State actualState;

void setup() {
  size(576, 640);
  
  // Loads
  loadUnits();
  
  // Nouveau State
  actualState = new Combat("combat_1");
  
  // Définir le State actuel
  enterState(actualState);
  
}

void draw() {
  
  actualState.update();
  actualState.render();

}