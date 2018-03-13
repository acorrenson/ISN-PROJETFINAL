// Classe représentant un état du jeu
/*
  Un état peut être une cinématique,
 un combat, un menu etc
 */
class State {
  String name;
  JSONObject data;

  State(String name) {
    // Init
    this.name = name;
  }

  void load() {
    // Chargement des données nécessaire au fonctionnement du State
  }

  // charger des données (name.json)
  void loadData() {
    println("loading datas for state " + this.name + " ...");
    try {
      this.data = loadJSONObject(getDataUrl(this.name));
      println("successfully loaded\n");
    } 
    catch(Exception e) {
      println("error loading datas for state" + this.name, e);
    }
  }

  // sauvegarder les données (name.json)
  void saveData() {
    println("saving datas for state " + this.name + " ...");
    try {
      saveJSONObject(this.data, getSavesUrl(this.name));
      println("successfully saved\n");
    } 
    catch (Exception e) {
      println("error saving datas for state" + this.name, e);
    }
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
    super("combat_1");
    this.PlayerX = 0;
  }

  void load() {
    // test de loadData();
    actualState.loadData();
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