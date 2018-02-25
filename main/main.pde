// block texture
PImage b;

// new map
Map map = new Map(9, 10);
PImage[] blocks = new PImage[1];

void setup() {
  // load assets
  b = loadImage("images/baseBlock.png");
  loadBlocks();
  
  // window settings
  size(640, 640);
  surface.setResizable(true);
  map.load();
}

void draw() {
  background(0);
  map.draw();
}

void mousePressed() {
  map.select();
}