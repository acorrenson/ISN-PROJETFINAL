// load all blocks
void loadBlocks() {
  blocks = new PImage[bn];
  for(int i = 0; i < blocks.length; i++) {
    blocks[i] = loadImage("images/block" + str(i) + ".png");
  }
}