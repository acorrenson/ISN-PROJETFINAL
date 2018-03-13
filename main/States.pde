// Classe représentant un état du jeu
/*
  Un état peut être une cinématique,
  un combat, un menu etc
*/
class State {
  String name;

  State(String name) {
    // Init
    this.name = name;
  }

  void load() {
    // Chargement des données nécessaire au fonctionnement du State
  }

  void update() {
    // Mise à jour des données
  }

  void render() {
    // Affichage (equivalent à Draw)
  }

  void leave() {
    // Changement de State
  }
}

// Exemple de State
/* 
 Cet état de test affiche un carré blanc qui
 navigue en boucle de Gauche à Droite
 */
class combat_1 extends State {

  int PlayerX;

  combat_1() {
    super("Combat #1");
    this.PlayerX = 0;
  }

  void load() {
    println("loaded");
  }

  void update() {
    if (this.PlayerX < width) {
      this.PlayerX += 5;
    } else {
      this.PlayerX = 0;
    }
  }

  void render() {
    background(0);
    fill(255);
    rect(this.PlayerX, height/2, 10, 10);
  }
}