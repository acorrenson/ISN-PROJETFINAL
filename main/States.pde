
/*
  Classes représentant un état du jeu
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

  void loadData() {
    // Chargement des données du State (en JSON)
    println("> Loading datas for state '" + this.name + "'...");
    try {
      this.data = loadJSONObject(getDataUrl(this.name));
      println("> Successfully loaded\n");
    } 
    catch(Exception e) {
      println("> Error loading datas for state '" + this.name + "'", e + "\n");
    }
  }

  void saveData() {
    // Sauvegarde des données du State (en JSON)
    println("> Saving datas for state '" + this.name + "'...");
    try {
      saveJSONObject(this.data, getSavesUrl(this.name));
      println("> Successfully saved\n");
    } 
    catch (Exception e) {
      println("> Error saving datas for state" + this.name, e + "\n");
    }
  }
  
  String data_getString(String field) {
    /*
      Récupérer des données (String)
      - filed : id de la donnée (String)
    */
    try {
      return this.data.getString(field);
    } 
    catch(Exception e) {
      println("> Could'nt get field '" + field + "' in datas", e + "\n");
    }
    return "undefined";
  }
  
  int data_getInt(String field) {
    /*
      Récupérer des données (Int)
       - filed : id de la donnée (String)
    */
    try {
      return this.data.getInt(field);
    } 
    catch(Exception e) {
      println("> Could'nt get field '" + field + "' in datas", e + "\n");
    }
    return 0;
  }
  
  void data_setString(String field, String toSet) {
    /*
      Sauvegarder une donnée (String)
       - filed : id de la donnée (String)
       - toSet : nouveau contenu (String)
    */
    try {
      this.data.setString(field, toSet);
    } 
    catch(Exception e) {
      println("> Could'nt set field '" + field + "' in datas", e + "\n");
    }
  }
  
  void data_setInt(String field, int toSet) {
    /*
      Sauvegarder une donnée (Int)
       - filed : id de la donnée (String)
       - toSet : nouveau contenu (Int)
    */
    try {
      this.data.setInt(field, toSet);
    } 
    catch(Exception e) {
      println("> Could'nt set field '" + field + "' in datas", e + "\n");
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


/*
 Exemple de State:
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
    // test de loadData()
    this.loadData();
    
    // test de data_setString()
    this.data_setString("test", "bye bye world");
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