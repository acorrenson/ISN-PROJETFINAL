# Aggraar
## G5 - Projet Final :: Julia-Aubert Correnson Gasnault

“Aggraar” est un jeu de stratégie développé dans le cadre de la spécialité ISN. Avec les règles d’un jeu de plateau, il vous plongera dans un monde futuriste, où l’espace est un lieu de non-droits. Rixes, règlements de comptes et abordages sont légions dans le cosmos. Vous même capitaine d’un vaisseau pirate, partit à la conquête de trésors fabuleux, vous devrez faire face aux autres aventuriers, tout aussi assoiffés d’or et de gloire. Êtes-vous prêt à affronter tous les dangers vous séparant du trésor d’Ann Bony ? Alors enfilez votre combi’ et en avant !

# Documentation

Pour permetter à chacun de comprendre la manière dont le jeu est codé, voici la documentation du projet.

## Les classes

### State

La classe State permet la création de scène de jeu. Chaque scène disposant de ses propres méthodes d'actualisation, de chargement de données, et d'affichage.

La classe *State* fournis des méthodes utilitaires qui facilite la cration de jeu. Par exemple, des méthodes de chargement
de fichiers JSON. Cependant, une instance de la classe State n'est pas utilisable en elle même. Pour créer des scènes de jeu, il est recommandé de faire dériver la classe State en utilisant le principe d'héritage. Vous pouvez ainsi définir le comportement précis de votre scène de jeu tout en bénéficiant des méthodes définies dans la classe State.

#### Exemple

```java

class SceneDeCombat extends State {
  
  int PointDeVie;

  SceneDeCombat(String name) {
    super(name);
    this.PointDeVie = 0;
  }

  load() {
    // charger le json correspondant au nom
    // (méthode fournie dans la classe State)
    this.loadData();
  
    // récupéerer une information dans le fichier JSON
    // (méthode fournie dans la classe State)
    this.PointDeVie = this.getAInt("PointDeVie");

    // afficher les points de vie
    println("Les nouveaux points de vie sont :", this.PointdeVie);
  }

}

// créer une scène de type SceneDeCombat
State maScene = new SceneDeCombat("PremierCombat");

```

#### Attributs

##### String name

Nom de la scène de jeu. 

##### JSONObject

Données JSON nécessaires à la scène de jeu

###### State(String name) [constructeur]

Constructeur de la classe.
Utiliser `new State()` pour créer une nouvelle scène de jeu.

+ paramètres:
  + *String* name : nom de la scène de jeu
+ valeur retournée:
  + *null*

###### State.load()

Méthode contenant les taches impliquant le chargement de données (images, fichiers JSON, etc)

+ paramètres:
  + *null*
+ valeur retournée:
  + *null*

###### State.update()

Méthode appellée environ 60 fois par seconde (avant chaque actualisation de l'écran).
C'est généralement ici que l'on code la logique de la scène de jeu (actualisation des positions, de l'état du joueurs et de son environnement etc).

+ paramètres:
  + *null*
+ valeur retournée:
  + *null*

##### State.render()

Méthode appellée environ 60 fois par seconde (à chaque actualisation de l'écran).
C'est généralement ici que l'on appelle les fonctions d'affichage et de dessin.

+ paramètres:
  + *null*
+ valeur retournée:
  + *null*

##### State.loadData()

Charge le fichier JSON situé à l'emplacement : `data/states/NAME.json` (où NAME correspond au nom de la scène donné en paramètre du constructeur).

Affiche un message d'erreur dans la console en cas d'échec du chargement.

Il est fortement recommandé d'utiliser cette méthode à l'intérieur de la méthode State.load() (voir exemple).

+ paramètres:
  + *null*
+ valeur retournée:
  + *null*

#### State.getAInt(String field)

Récupère une donnée de type *int* dans le fichier JSON de la scène.

+ paramètres:
  + *String* field: nom du champs dont on veut récupérer le contenu dans le fichier JSON
+ valeur retournée:
  + *int* Entier voulue (si il existe)
  + *int* 0 (en cas d'erreur)

### State.getAString(String field)

Récupère une donnée de type *String* dans le fichier JSON de la scène.

+ paramètres:
  + *String* field: nom du champs dont on veut récupérer le contenu dans le fichier JSON
+ valeur retournée:
  + *String* Chaine de caractères voulue (si il existe)
  + *String* undefined (en cas d'erreur)






