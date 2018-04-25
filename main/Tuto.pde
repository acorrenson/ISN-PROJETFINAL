
class Tuto extends State {

  PImage frame;
  Button[] nav;

  Tuto (String name) {
    super(name);
    this.frame = assets[24];

    this.nav = new Button[2];

    this.nav[0] = new Button("<", 64, 480, 50, 50);
    this.nav[1] = new Button(">", width - 114, 480, 50, 50);
  }

  void renderButtons() {
    for (int i = 0; i < nav.length; i++) {
      noFill();
      stroke(0, 0, 255);
      strokeWeight(3);
      rect(nav[i].x, nav[i].y, nav[i].w, nav[i].h);
      fill(255);
      textAlign(CENTER, BOTTOM);
      textSize(50);
      text(nav[i].name, nav[i].x + nav[i].w/2 , nav[i].y + nav[i].h);
    }
  }

  void mousePressed() {
    for (int i = 0; i < nav.length; i++) {
      if (nav[i].hover()) {
        println(i == 0 ? "prev" : "next"); 
      }
    }
  }

  void render() {
    background(0, 6, 45);
    imageMode(CENTER);
    image(assets[27], width/2, height/2 - 60, 400, 400);
    renderButtons();
  }

}