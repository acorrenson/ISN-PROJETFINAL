class Scenario extends State {

  int x = 0;
  int y = 0;
  
  Scenario() {
    super("scenario");
  }


  void update() {

    y = int(checkMouse(y));


    background(255);
    image(assets[38], x, y);

    boutonSortie(y);
  }

  int checkMouse(int y) {

    if (y >= -30) {
      y = -30;
    }

    if (y <= -5930) {
      y = -5930;
    }

    if (mouseY <= 192 && mouseY >= 64) {
      y = y + 20;
    }

    if (mouseY <= 64 ) {
      y = y + 30;
    }

    if (mouseY <= 576 && mouseY >= 448) {
      y = y - 20;
    }

    if (mouseY >= 576) {
      y = y - 30;
    }
    return y;
  }

  void boutonSortie(int y) {

    if (y <= -5700) {
      strokeWeight(2);
      stroke(0);      
      fill(255);
      rect(400, 600, 100, 25);

      textSize(12);
      fill(255, 0, 0);
      text("Poursuivre", 415, 615);

      if (mousePressed) {
          if (mouseX >= 350 && mouseX <= 550 && mouseY >= 550 && mouseY <= 645) {
          println("Passage tuto");
          enterState( new Tuto("tuto") );
        }
      }
    }
  }
}
