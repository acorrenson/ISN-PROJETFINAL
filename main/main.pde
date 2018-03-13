
State actualState;

void setup() {
  size(480, 640);
  enterState(new combat_1());
}

void draw() {
  actualState.update();
  actualState.render();
}