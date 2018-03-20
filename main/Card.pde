// UNE CARTE
class Card {

  int initX;
  int initY;
  int x;
  int y;
  int w;
  int h;
  int unit;

  boolean selected; // carte séléctionnée ou non

  int clickW; // position du clique de la souris dans la carte
  int clickH;

  // constructor
  Card(int x, int y, int unit) {
    this.initX = x;
    this.initY = y;
    this.x = this.initX;
    this.y = this.initY;
    this.unit = unit;

    this.w = 50;
    this.h = 100;
  }

  void select() {
    this.selected = true;
    this.clickW = mouseX - this.x;
    this.clickH = mouseY - this.y;
  }

  void reset() {
    this.x = this.initX;
    this.y = this.initY;
    this.selected = false;
  }

  void render() {
    fill(255);
    if(!this.selected) {
      rect(this.x, this.y, this.w, this.h);
    } else {
      rect(mouseX - this.clickW, mouseY - this.clickH, this.w, this.h);
    }
  }
}