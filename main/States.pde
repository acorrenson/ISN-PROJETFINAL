
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
      saveJSONObject(this.data, getSaveUrl(this.name));
      println("> Successfully saved\n");
    } 
    catch (Exception e) {
      println("> Error saving datas for state" + this.name, e + "\n");
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
      println("> Could'nt get field '" + field + "' in datas", e + "\n");
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
      println("> Could'nt get field '" + field + "' in datas", e + "\n");
    }
    return 0;
  }

  void setAString(String field, String toSet) {
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

  void setAInt(String field, int toSet) {
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