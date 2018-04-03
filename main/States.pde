
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
    /*
      Cette méthode est appellée
      au moment de l'entré dans l'état
      par la fonction enterState()
    */
  }

  void loadData() {
    // Chargement des données du State (en JSON)
    println("> Loading datas for state '" + this.name + "'...");
    try {
      this.data = loadJSONObject(getStateUrl(this.name));
      println("< Success\n");
    } 
    catch(Exception e) {
      println("< Error loading datas for state '" + this.name + "'", e + "\n");
      stop();
    }
  }
  
  String getAString(String field) {
    /*
      Récupérer des données (String)
      - filed : id de la donnée (String)
    */
    try {
      return this.data.getString(field);
    } 
    catch(Exception e) {
      println("< Could'nt get field '" + field + "' in datas", e + "\n");
    }
    return "undefined";
  }

  int getAInt(String field) {
    /*
      Récupérer des données (Int)
      - filed : id de la donnée (String)
    */
    try {
      return this.data.getInt(field);
    } 
    catch(Exception e) {
      println("< Could'nt get field '" + field + "' in datas", e + "\n");
    }
    return 0;
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
