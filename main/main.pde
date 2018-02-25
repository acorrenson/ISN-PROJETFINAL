// new map
Map map = new Map(9, 10);

// all textures for blocks
PImage[] blocks;// = new PImage[1];

// blocks values
int bw; // block's width
int bh; // block's height
int bn; // number of blocks

void setup() {
  // assets settings
  bw = 64;
  bh = 64;
  bn = 1;
  
  // load assets
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