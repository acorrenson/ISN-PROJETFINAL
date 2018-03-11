// TILE CLASS
class Tile {
  PImage texture;
  int x;
  int y;

  Tile(int x, int y, int textureIndex) {
    this.x = x;
    this.y = y;
    this.texture = blocks[textureIndex];
  }

  void draw() {
    image(this.texture, this.x, this.y);
  }

  // get center x and y
  int cx() {
    return (int) this.x + bw/2;
  }

  int cy() {
    return (int) this.y + bh/4;
  }
}

// MAP CLASS
class Map {
  Tile[][] array; // all tiles
  int w; // map width
  int h; // map height
  int selectedX; // actual selected tile X
  int selectedY; // actual selected tile Y

  Map (int w, int h) {
    this.array = new Tile[h][w];
    this.w = w;
    this.h = h;
  }
  
  // fill the array with tiles
  void load() {
    for (int i = 0; i < this.array.length; i++) {
      for (int j = 0; j < this.array[0].length; j++) {
        /* - get x and y - */
        // offset X for even rows (evenNumber%2 = 0)
        int x = j * bw + i%2 * (bw/2);
        int y = i * (bh/4) + bh/4;
        this.array[i][j] = new Tile(x, y, 0);
      }
    }
  }
  
  void draw() {
    for (int i = 0; i < this.array.length; i++) {
      for (int j = 0; j < this.array[0].length; j++) {
        this.array[i][j].draw();
      }
    }
    int x = this.array[this.selectedY][this.selectedX].cx();
    int y = this.array[this.selectedY][this.selectedX].cy();
    ellipse(x, y, 10, 10);
  }

  void select() {
    for (int i = 0; i < this.array.length; i++) {
      for (int j = 0; j < this.array[0].length; j++) {
        int x = this.array[i][j].cx();
        int y = this.array[i][j].cy();
        if (dist(mouseX, mouseY, x, y) <= bw/4) {
          this.selectedX = j;
          this.selectedY = i;
        }
      }
    }
  }
}