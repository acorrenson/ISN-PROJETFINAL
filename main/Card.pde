// UNE CARTE
class Card {

  int initX;
  int initY;
  int x;
  int y;
  int w;
  int h;
  int unit;

  boolean show; // montrer l'image ou non
  boolean selected; // carte séléctionnée ou non
  boolean placed;

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
    this.placed = false;
  }

  // déplacement d'une cate (drag)
  void move() {
    if (mousePressed && (collide(mouseX, mouseY, this.x, this.y, this.w, this.h) || this.selected )) {
      // si souris pressé + (souris dans la carte OU carte déja séléctionnée)
      if (!this.selected) {
        this.clickW = mouseX - this.x;
        this.clickH = mouseY - this.y;
        this.selected = true;
      }
      this.x = mouseX - this.clickW;
      this.y = mouseY - this.clickH;
    }
  }

  void place(int aX, int aY, int aW, int aH) {
    if (!mousePressed && this.selected) {
      this.selected = false;
      // si on relache dans la zonne autorisée (plateau)
      if ( mouseX >= aX && mouseX <= (aX + aW)
        && mouseY >= aY && mouseY <= (aY + aH)) {
        this.placed = true;
      } else {
        this.reset();
      }
    }
  }

  void reset() {
    this.x = this.initX;
    this.y = this.initY;
    this.placed = false;
    this.selected = false;
  }

  void render() {
    fill(255);
    rect(this.x, this.y, this.w, this.h);
  }
}