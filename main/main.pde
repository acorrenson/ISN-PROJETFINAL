
State actualState;
Card c = new Card(10, 10, 0);

void setup() {
  size(512, 640);
  
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