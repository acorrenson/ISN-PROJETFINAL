
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
    return (int) this.x + this.texture.width/2;
  }

  int cy() {
    return (int) this.y + this.texture.height/4;
  }
}

class Map {
  // all tiles
  Tile[][] array;
  int w; // map width
  int h; // map height
  int selectedX; // actual selected tile X
  int selectedY; // actual selected tile Y

  Map (int w, int h) {
    this.array = new Tile[h][w];
    this.w = w;
    this.h = h;
  }

  void load() {
    for (int i = 0; i < this.array.length; i++) {
      for (int j = 0; j < this.array[0].length; j++) {
        /* - get x and y - */
        // offset X for even rows (evenNumber%2 = 0)
        int x = j * b.width + i%2 * (b.width/2);
        int y = i * (b.height/4) + b.height/4;
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
        int x = this.array[i][j].x + b.width/2;
        int y = this.array[i][j].y + b.height/4;
        if (dist(mouseX, mouseY, x, y) <= b.width/4) {
          this.selectedX = j;
          this.selectedY = i;
        }
      }
    }
  }
}