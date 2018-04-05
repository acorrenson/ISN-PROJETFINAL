
/***********************************************************************\
 *
 * PROJET : Aggraar
 *
 * ARBORESCENCE :
 *    ■ main
 *      ■ data
 *          ■ images
 *            • unitsSpritesheet.png
 *          ■ sounds
 *          ■ states
 *      • Card.pde
 *      • Combat.pde
 *      • main.pde
 *      • States.pde
 *      • Units.pde
 *      • Utils.pde
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
  
  // Définir le State actuel
  enterState(new Combat("combat_1"));
  
}

void draw() {
  
  actualState.update();
  actualState.render();

}
