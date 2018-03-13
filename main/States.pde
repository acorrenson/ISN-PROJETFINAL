
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

class combat_1 extends State {

  combat_1() {
  
    super("Combat #1");
  
  }
  
  void load() {
  
    println("loaded");
  
  }
  
  void render() {
    background(0);
    
    fill(255);
    rect(5, 5, 10, 10);
  
  }

}
