
/*************************************************************************\
 *
 *                             PROJET : Aggraar
 * 
 *                               - GROUPE 5 -
 *    
 * AUTEURS :    Simon Julia-Aubert    Arthur Correnson    Louis Gasnault
 *
\*************************************************************************/

import processing.sound.*;

// L'état actuel du jeu
State actualState;

void setup() {
  size(512, 672);
  noSmooth();

  // Loads
  loadAssets();
  loadSounds();
  loadUnits();
  pixelFont = createFont("data/font/BoCSFont.ttf", 5);
  
  surface.setIcon( assets[0].get(0, 0, 32, 32) );
  surface.setTitle("Agraar");

  // Définir l'état actuel
  enterState( new Scenario() );
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

void mouseMoved() {
  actualState.mouseMoved();
}
