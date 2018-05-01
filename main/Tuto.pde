
class Tuto extends State {

  Button[] nav;
  int slideIndex;
  int maxIndex;

  Tuto (String name) {
    // constructeur de la classe parente
    super(name);

    // éléments d'interface

    // tableau des bouttons
    this.nav = new Button[2];
    // bouton 'prev' (avant)
    this.nav[0] = new Button("<", 64, 480, 50, 50);
    // bouton 'next' (après)
    this.nav[1] = new Button(">", width - 114, 480, 50, 50);

    // gestion des diapositives
    this.slideIndex = 0;
    this.maxIndex = 7;

  }

  void renderButtons() {
    /*
      dessiner les boutons (avant > arrière <)
    */
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

  void nextSlide() {
    /*
      passer à la diapositive suivante
    */
    if (slideIndex < maxIndex) {
      slideIndex++;
      println("next : " + slideIndex);
    } else if (slideIndex == maxIndex) {
      this.leave();
    }
  }

  void prevSlide() {
    /*
      passer à la diapo précédente
    */
    if (slideIndex > 0) {
      slideIndex--;
      println("prev : " + slideIndex);
    }
  }

  void mousePressed() {
    /*
      quand la souris est pressé
      si les boutons sont ciblés => changer de diapositive
    */
    for (int i = 0; i < nav.length; i++) {
      if (nav[i].hover()) {
        if (i==0) prevSlide();
        else nextSlide();
      }
    }
  }

  void render() {
    background(0, 6, 45);
    imageMode(CENTER);
    image(assets[27 + slideIndex], width/2, height/2 - 60, 400, 400);
    renderButtons();
    imageMode(CORNER);
  }
  
  void leave() {
    enterState( new Combat("combat_1") );
  }

}
