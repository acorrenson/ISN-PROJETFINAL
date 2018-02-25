
PImage b = new PImage();

// index of the selected tile
int sx = 0;
int sy = 0;

void setup() {
  // load assets
  b = loadImage("images/baseBlock.png");
  
  // window settings
  size(640, 640);
  surface.setResizable(true);
}

void draw() {
  background(0);
  // fix number of block according to width
  drawBlocks((int) width/b.width-1, (int) 2*height/b.height);
  drawSelected();
}

void mousePressed() {
  // select a tile on click event
  click((int) width/b.width - 1, (int) 2*height/b.height);
}