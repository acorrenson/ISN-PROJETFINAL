
State actualState;

void setup() {
  size(512, 640);
  
  // Loads
  loadUnits();
  
  // Définir le State actuel
  enterState(new Combat("combat_1"));
  
}

void draw() {
  
  actualState.update();
  actualState.render();

}
