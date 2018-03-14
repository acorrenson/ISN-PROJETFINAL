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
    println("loading datas for state \'" + this.name + "\'...");
    try {
      this.data = loadJSONObject(getDataUrl(this.name));
      println("successfully loaded\n");
    } 
    catch(Exception e) {
      println("error loading datas for state \'" + this.name + "\'", e + "\n");
    }
  }

  // sauvegarder les données (name.json)
  void saveData() {
    println("saving datas for state \'" + this.name + "\'...");
    try {
      saveJSONObject(this.data, getSavesUrl(this.name));
      println("successfully saved\n");
    } 
    catch (Exception e) {
      println("error saving datas for state" + this.name, e + "\n");
    }
  }
  
  // récupérer une donnée de type String
  // field = nom du champs dans lequel est stoquée la donnée
  String gS(String field) {
    try {
      return this.data.getString(field);
    } 
    catch(Exception e) {
      println("could'nt get field '" + field + "' in datas", e + "\n");
    }
    return "undefined";
  }
  
  // récupérer une donnée de type Int
  // field = nom du champs dans lequel est stoquée la donnée
  int gI(String field) {
    try {
      return this.data.getInt(field);
    } 
    catch(Exception e) {
      println("could'nt get field '" + field + "' in datas", e + "\n");
    }
    return 0;
  }
  
  // modifier une donnée de type Int
  void sI(String field, int toSet) {
    try {
      this.data.setInt(field, toSet);
    } 
    catch(Exception e) {
      println("could'nt set field '" + field + "' in datas", e + "\n");
    }
  }
  
  // modifier une donnée de type String
  void sS(String field, String toSet) {
    try {
      this.data.setString(field, toSet);
    } 
    catch(Exception e) {
      println("could'nt set field '" + field + "' in datas", e + "\n");
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
    super("combat_2");
    this.PlayerX = 0;
  }

  void load() {
    // test de loadData()
    this.loadData();
    
    // test de sS()
    this.sS("test", "bye bye world");
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
    
    // test de gS() -> affiche le contenu du champ "test"
    // inscrit dans datas/combat_1.json
    //text(this.gS("test"), 20, 20);
  }
}