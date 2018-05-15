
/*
  Classes représentant un état du jeu
*/

class State {
  
  /*
    name : nom de l'état, permet de récuper ses données JSON
    data : une variable de type JSONObject où l'on stocke les données relative à l'état
  */

  String name;
  JSONObject data;

  State(String name) {
    
    // Constructeur de la classe
    
    this.name = name;
  }

  void load() {
    
    /*
      Charge les données nécessaire au fonctionnement du State
      Cette méthode est appellée au moment de l'entré dans l'état par la fonction enterState()
    */
    
  }

  void loadData() {
    
    // Charge les données JSON de l'état
    
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
      Récupère une donnée de type String
        - field : identifiant de la donnée ciblée
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
    
    /*
      Actualisation de l'état, cette méthode est appelée dans la fonction "draw" de Processing (donc 60 fois par seconde)
      Elle va actualiser les données (déplacements des unités, points de vies, etc ...)
    */
    
  }

  void render() {
    
    /*
      Actualisation de l'afichage de l'état, cette méthode est également appelée dans la fonction "draw" de Processing
      Elle va actualiser l'affichage du jeu suite à l'actualisation des données par "update"
    */
    
  }

  void leave() {
    
    /*
      S'execute quand on quitte l'état
      Appelle la fonction "enterState"
    */
    
  }
  
  void keyDown(int k) {}

  void mousePressed() {}
  
  void mouseMoved() {}
}
