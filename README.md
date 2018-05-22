# Aggraar
## G5 - Projet Final :: Julia-Aubert Correnson Gasnault

“Aggraar” est un jeu de stratégie développé dans le cadre de la spécialité ISN. Avec les règles d’un jeu de plateau, il vous plongera dans un monde futuriste, où l’espace est un lieu de non-droits. Rixes, règlements de comptes et abordages sont légions dans le cosmos. Vous même capitaine d’un vaisseau pirate, partit à la conquête de trésors fabuleux, vous devrez faire face aux autres aventuriers, tout aussi assoiffés d’or et de gloire. Êtes-vous prêt à affronter tous les dangers vous séparant du trésor d’Ann Bony ? Alors enfilez votre combi’ et en avant !

# Documentation

Pour permetter à chacun de comprendre la manière dont le jeu est codé, voici la documentation du projet.



## Les classes


### CLASSE State

La classe State permet la création de scène de jeu. Chaque scène disposant de ses propres méthodes d'actualisation, de chargement de données, et d'affichage.

La classe *State* fournit aussi des méthodes utilitaires qui facilitent la création de jeu. Par exemple, des méthodes de chargement
de fichiers JSON. Cependant, la classe State n'est pas utilisable toute seule. Pour créer des scènes de jeu, il est nécessaire de faire dériver la classe State en différentes classes filles selon les besoins. Vous pouvez ainsi définir le comportement précis de votre scène de jeu tout en bénéficiant des méthodes déjà définies dans la classe State (que vous n'avez donc pas besoin de recoder).

#### Exemple

```java

// création d'une nouvelle classe dérivant de la classe State
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

##### JSONObject data

Données JSON nécessaires à la scène de jeu

##### State(String name) [constructeur]

Constructeur de la classe.
Utiliser `new State()` pour créer une nouvelle scène de jeu.

+ paramètres:
  + *String* name : nom de la scène de jeu
+ valeur retournée:
  + *void*

##### State.load()

Méthode contenant les taches impliquant le chargement de données (images, fichiers JSON, etc)

**paramètres:**
  + *void*
**valeur retournée:**
  + *void*

##### State.leave()

Méthode appellée à la sortie de la scène. On peut y définir les tâches à faire avant de quitter la scène
(sauvegarder un score, afficher un message etc)

**paramètres:**
  + *void*
**valeur retournée:**
  + *void*

##### State.update()

Méthode appellée environ 60 fois par seconde (avant chaque actualisation de l'écran).
C'est généralement ici que l'on code la logique de la scène de jeu (actualisation des positions, de l'état du joueurs et de son environnement etc).

**paramètres**
  + *void*
**valeur retournée:**
  + *void*

##### State.render()

Méthode appellée environ 60 fois par seconde (à chaque actualisation de l'écran).
C'est généralement ici que l'on appelle les fonctions d'affichage et de dessin.

**paramètres:**
  + *void*
**valeur retournée:**
  + *void*

##### State.loadData()

Charge le fichier JSON situé à l'emplacement : `data/states/NAME.json` (où NAME correspond au nom de la scène donné en paramètre du constructeur).

Affiche un message d'erreur dans la console en cas d'échec du chargement.

Il est fortement recommandé d'utiliser cette méthode à l'intérieur de la méthode State.load() (voir exemple).

+ paramètres:
  + *void*
+ valeur retournée:
  + *void*

##### State.getAInt(String field)

Récupère une donnée de type *int* dans le fichier JSON de la scène.

+ paramètres:
  + *String* field: nom du champs dont on veut récupérer le contenu dans le fichier JSON
+ valeur retournée:
  + *int* Entier voulue (si il existe)
  + *int* 0 (en cas d'erreur)

##### State.getAString(String field)

Récupère une donnée de type *String* dans le fichier JSON de la scène.

+ paramètres:
  + *String* field: nom du champs dont on veut récupérer le contenu dans le fichier JSON
+ valeur retournée:
  + *String* Chaine de caractères voulue (si il existe)
  + *String* undefined (en cas d'erreur)


### Units

La classe **Unit** représente les SOLDATS en jeu.

#### attributs

##### String name

Nom de l'unité ("Clone", "Radio", "Gun", "Admiral", "Medic" ou "Flame Gun")

##### int lives

Nombre de points de vie d'une unité

##### int maxLives

Nombre maximum de points de vie d'une unité

##### int step

Vitesse de déplacement (par tour) d'une unité

##### int steps

Pas déjà effectué ce tour par l'unité

##### int faction

Faction de l'unité : alliée (0) ou ennemie (1)

##### int side

Côté de l'unité : de face (0) ou de dos (1)

##### idSprite

Index de l'image correspondant à l'unité dans le tableau des images (assets)

#### méthodes

##### Unit(String name, int faction, int side) [constructeur]

Constructeur de la classe.

+ paramètres:
  + *String* name: nom de l'unité
  + *int* faction: faction de l'unité
  + *String* side: côté de l'unité 
+ valeur retournée:
  + *void*

##### void stop()

Interdire tout déplacement de l'unité jusqu'à contre-odre.

+ paramètres:
  + *void* 
+ valeur retournée:
  + *void*

##### boolean canMove()

Indique si l'unité peut encore se déplacer ce tour ou non.

+ paramètres:
  + *void* 
+ valeur retournée:
  + *boolean* true: si l'unité peut encore se déplacer 
  + *boolean* false: si l'unité ne peut plus se déplacer ce tour 

##### void render(int x, int y)

Affiche l'unité à l'écran en position (X, Y)

+ paramètres:
  + *void* 
+ valeur retournée:
  + *void*



## les variables utilitaires

### PFont pixelFont

La police de caractère utilisée dans le jeu

### int sqrSize

La taille d'une case sur le terrain (en pixel)

### int nbCards

Le nombre de cartes maximales dans la main du joueur

### int cardWidth

La largeur d'une carte à jouer (en pixel)

## int cardHeight

La hauteur d'une carte à jouer (en pixel) 

## int ALLY

Entier désignant/codant la faction "alliée"

## int ENY

Entier désignant/codant la faction "ennemie"

## int BACK

Entier désignant/codant le côté "de dos"

## int FRONT

Entier désignant/codant le côté "de face"

## PImage assets

Tableau contenant toutes les images du jeu.
On pourra utiliser la fonction `gai()` pour chercher
une image précise dedans.

## Les fonctions

Plusieurs fonctions utilitaires sont disponibles en plus des classes.

### void enterState(State newState)

Entre dans une nouvelle scène de jeu en prenant le soin de charger
les données dont elle à besoin.

#### exemple

```java

enterState( new State('MaSceneDeJeu') );

```

+ paramètres:
  + *State* newState: scène de jeu dans laquelle on souhaite entrer
+ valeur retournée:
  + *void*

### String getStateUrl(String name)

Retourne le chemin correspondant au fichier JSON d'une scène de jeu.

+ paramètres:
  + *String* name: nom de la scène de jeu concernée
+ valeur retournée:
  + *void*

### void loadAssets()

Charge toutes les images nécessaire. Découpe les images regroupant plusieurs sous-images.
Toutes les images chargées sont ensuite stockée dans un tableau.

### void loadUnits()

Charge les données JSON relatives au soldats (caractéristiques)

+ paramètres:
  + *void*
+ valeur retournée:
  + *void*

### int gai()

*Get Asset Index* Récupère l'indexe d'une image de soldat dans le tableau contenant toutes les images en mémoire.

+ paramètres:
  + *String* name: type de soldat ("Clone", "Radio", "Gun", "Admiral", "Medic" ou "Flame Gun")
  + *int* faction: faction du soldat
  + *int* side: de face (0) ou de dos (1)
+ valeur retournée:
  + *int* index de l'image ciblée dans le tableau **assets**

