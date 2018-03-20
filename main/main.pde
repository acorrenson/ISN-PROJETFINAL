
State actualState;
Card c = new Card(10, 10, 0);

// Test
Combat Yolo;
PImage back;

void setup() {
  size(512, 640);
  
  // Loads
  loadUnits();
  
  // Nouveau State
  actualState = new Combat("combat_1");
  
  // Définir le State actuel
  enterState(actualState);
  
  // Test de combat
  Yolo = new Combat("Toto");
  
  back = loadImage("data/images/background.png");
  
}

void draw() {
  
  actualState.update();
  actualState.render();
  image(back, 0, 0);
}

void mouseMoved() {

  println(Yolo.returnIndex());

}