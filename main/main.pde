
/*************************************************************************\
 *
 *                             PROJET : Aggraar
 * 
 *                               - GROUPE 5 -
 *    
 * AUTEURS :    Simon Julia-Aubert    Arthur Correnson    Louis Gasnault
 *
\*************************************************************************/

// L'état actuel du jeu
State actualState;

void setup() {
  size(512, 640);
  noSmooth();

  // Loads
  loadAssets();
  loadUnits();
  pixelFont = createFont("data/font/BoCSFont.ttf", 5);

  // Définir l'état actuel
  enterState( new Combat("combat_1") );
  // enterState( new Tuto("tuto") );
}

void draw() {

  actualState.update();
  actualState.render();
}

void keyPressed() {

  if (keyCode == ESC) {
    key = 0;
    actualState.keyDown(27);
  } else if (keyCode == ENTER) {
    screenshot();
  } else {
    actualState.keyDown(key);
  }
}

void mousePressed() {
  actualState.mousePressed();
}
