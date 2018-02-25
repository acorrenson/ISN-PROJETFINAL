// draw blocks
// w = number of block displayed on X axe
// h = number of block displayed on Y axe

void drawBlocks(int w, int h) {
  for (int i = 0; i < h; i++) {
    for (int j = 0; j < w; j++) {
      // draw the block
      image(b, j * b.width + i%2 * (b.width/2) + b.width/4, i * (b.height/4) + b.height/4);
    }
  }
}

void drawSelected() {
  // compute center of the block
  int x = sx * b.width + sy%2 * (b.width/2) + b.width/2 + b.width/4;
  int y = sy * (b.height/4) + b.height/2;
  // draw the circle
  noFill();
  stroke(255, 0, 0);
  ellipse(x, y, b.width/2, b.width/2);
  // text the position of the selected block
  textSize(32);
  text("x : " + str(sx) + " y : " + str(sy), 32, height - 40);  
}