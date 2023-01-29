# ``LaboSudoku_FW``

Un laboratoire d'expérimentation du Sudoku, pour découvrir, explorer, comprendre, apprendre.

Lors de la résolution, l'état de la grille et des connaissances sur cette grille est donné par un ensemble de faits du type :

	Il y a une bijection de C (un ensemble de cases) vers V (un ensemble de valeurs).
	
C est une "zone de bijection". 

Au départ il y en a 27 : lignes, colonnes et carrés, et elles sont en bijection avec l'ensemble 1...9
Ce sont toutes des restrictions d'une application "valeur" de l'ensemble des 81 cases dans l'ensemble des 9 chiffres.

Il peut se produire deux sortes d'événements de base : 

- la découverte d'un coup impossible : valeur(case) ≠ chiffre
- la découverte d'un coup obligé : valeur(case) = chiffre. Cela crée alors une bijection singleton.
- la découverte d'un lien unaire (une valeur obligatoirement présente dans deux cases)
- la découverte d'un lien binaire (deux valeurs obligatoirement présentes dans deux cases)

et des événements dérivés :

- Dans telle zone, telle valeur ne peut aller que dans telle paire de cases.
- Dans telle zone, telle paire de valeurs ne peut aller que dans telle paire de cases, et cela crée une nouvelle bijection.

Chacun de ces événements produit en réaction une mise à jour de la base de faits (on l'augmente et/ou on la spécialise, on la minimise). Chaque bijection peut se restreindre. Quand une bijection se restreint à un couple de singletons (case, valeur), alors c'est un coup obligé. Quand une bijection se restreint à un couple de paires, on peut en déduire des éliminations.

Une grille vide a 27 bijections de 9 cases vers 9 valeurs.
Chaque jeu d'un coup restreint les bijections des 3 zones auxquelles la case appartient : ligne, colonne, carré.

Une étape du raisonnement consiste à découvrir une bijection qu'on peut restreindre. On peut la découvrir en se focalisant sur un ensemble de cases (quelles sont les valeurs candidates dans cette région) ou sur un ensemble de valeurs (quelles sont les cases candidates pour ces valeurs).

## Règles

### Règles directes

1. Si dans une zone 8 des cases sont interdites pour une valeur, alors il faut mettre la valeur dans la neuvième case.

2. Si dans une zone 8 des valeurs sont interdites pour une case, alors dans cette case il faut mettre la neuvième valeur


Ces règles sont directes parce qu'elles permettent de trouver directement la valeur d'une case.

### Règles indirectes

1. Si dans une zone une valeur ne peut aller que dans deux cases et si une autre zone contient ces deux cases, alors toutes les autres cases de la deuxième zone sont interdites pour la valeur. Le cas typiques est le cas de deux cases d'un même carré qui sont alignées sur une ligne ou une colonne. L'effet est d'éliminer des cases pour une valeur à l'extérieur de la zone.

2. Si dans une zone une paire de valeurs ne peut aller que dans la même paire de cases, alors toutes les autres valeurs sont interdites dans le reste de la zone. L'effet est d'éliminer des cases pour deux valeurs à l'intérieur de la zone.

Ces règles sont indirectes parce qu'elles ne permettent pas de trouver directement la valeur d'une case, mais elles fournissent des informations à mémoriser (annotations), qui plus tard aideront à la découverte de valeurs.

## Etapes de jeu

Une partie se déroule en plusieurs étapes de raisonnement, chaque étape donnant lieu à  l'affirmation d'un fait qu'on mémorise en l'écrivant de manière symbolique dans la grille.

Les principaux types de contraintes humainement détectables et mémorisables sont :

- valeur d'une case : telle case ne peut recevoir que telle valeur. Action: on écrit la valeur dans la case.
- annotation des valeurs candidates pour une case dans la grille. Cas particulier : une case, deux valeurs (telle case ne peut recevoir que ces deux valeurs). Action : on écrit ces valeurs avec un formalisme spécial dans la case.
- annotation de cases candidates pour une valeur dans une zone. Cas particulier : une valeur, deux cases (telle valeur ne peut aller que dans une de ces deux cases). Action : on écrit cette valeur avec un formalisme spécial en lien avec les deux cases.
- annotation de bijection dans une zone. Cas particulier : deux cases, deux valeurs (il y a une bijection entre ces deux cases et ces deux valeurs). Action : on écrit ces deux valeurs avec un formalisme spécial en lien avec ces deux cases.

Le fait "valeur d'une case" n'est qu'un cas particulier du fait "bijection" : il y a une bijection d'une case vers une valeur dans chacune des 3 zones qui contient la case.

## Contraintes 

Ce qu'il y a d'écrit dans une grille constitue une base de contraintes. Le but est d'arriver à résoudre le problème en se limitant à cette base de contraintes. Toute étape du jeu modifie la base de contraintes.

La forme la plus générale d'un fait est d'un des deux types suivants (sous forme de prédicats) :

    ValeursCandidates(cases, chiffres)
    CasesCandidates(zone, cases, chiffres)

Focalisation par cases :
`ValeursCandidates(cases, chiffres)` veut dire : l'ensemble des valeurs des cases (encore possibles à ce stade du jeu) est inclus dans l'ensemble des chiffres. 

Focalisation par valeurs :
`CasesCandidates(zone, cases, chiffres)` veut dire : l'ensemble des antécédents des chiffres dans la zone (encore posibles à ce stade du jeu) est inclus dans l'ensemble des cases. Exemple : l'ensemble des antécédents de {1, 2} dans le carré (haut, gauche) est {Aa, Bb}. Cet exemple est le cas d'une sous-bijection. 

Dans ces deux prédicats, les cases doivent appartenir à une même zone (peut-être pas nécessaire ?)

Le fait que les cases appartiennent à une même zone implique qu'il y a une injection de l'ensemble des cases dans l'ensemble des chiffres, d'où le cas particulier : quand le nombre de cases est égal au nombre de chiffres, il s'agit d'une bijection. Dès qu'on découvre une bijection, elle est définitive : elle reste vraie pendant toute la partie.

Mais un joueur humain se limite aux cas où "cases" et "valeurs" ne comportent qu'un ou deux éléments.

Informatiquement, il peut y avoir deux fonctions permettant de trouver des faits : 

    valeursCandidates(cases)
    casesCandidates(valeurs, zone) 

Mais cela n'a de sens que si on sait sur quel ensemble de cases ou de valeurs se focaliser.

Et on peut mémoriser et tenir à jour deux ensembles de faits (un par type).
Mais il faut aussi des fonctions de recherche heuristique qui permettent de savoir sur quoi se focaliser. Seule l'applicaton préalable des heuristiques permettra de faire des ajouts de faits pertinents et pas trop coûteux à découvrir.

## Découverte des liens

### Liens unaires 

#### 1 valeur, 2 cases

Lorsqu'on cherche à placer une valeur dans une zone ("où sont les cases possibles pour cette valeur dans cette zone ?") et qu'on constate qu'il n'y a que deux cases possibles, on note un lien unaire (cette valeur, ces deux cases). Ce lien est indépendant de la focalisation initiale sur la zone, il est valable pour toutes les zones qui contiennent les deux cases.

    Notation : [case1] --(valeur)-- [case2]

On pourrait avoir un dictionnaire : valeur -> couples de cases

Deux cases sont liées par une valeur. Si une zone contient ces deux cases, alors les autres valeurs sont interdites pour les autres cases de la zone. Cela interviendra quand pour ces cases on se posera la question "cette valeur peut-elle aller dans cette case (dans la même zone) ?". Si la case est différente de case1 et case2, la réponse sera non.

#### 1 case, 2 valeurs

Lorsqu'on cherche à remplir une case par des valeurs ("quelles sont les valeurs possibles pour cette case ?") et qu'on constate qu'il n'y a que deux valeurs possibles, on note ce fait (cette case, ces valeurs).

    Notation : (valeur1) --[case]-- (valeur2)

On pourrait avoir un dictionnaire : case -> couples de valeurs

Deux valeurs sont liées par une case. Pour cette case, elles sont exclusives. Si par la suite on apprend que valeur1 est la valeur d'une autre case dans la même zone, alors la valeur de la case du lien est valeur2.

### Liens binaires : 2 cases, deux valeurs

Lorsqu'on a découvert deux liens unaires pour le même couple de cases avec des valeurs différentes, alors on peut affirmer un lien binaire, c'est-à-dire une bijection :

    Notation : [case1] --(valeur1, valeur2)-- [case2]

dictionnaire : couple de valeurs -> couples de cases

Deux cases sont liées entre elles par deux valeurs. Si une zone contient ces deux cases, alors les autres valeurs sont interdites pour les autres cases de la zone et les autres cases de la zone sont interdites pour chacune des deux valeurs. Donc ce lien peut intervenir dans chacun des types de recherche "où placer telle valeur ?" pour une valeur différente de valeur1 et valeur2 (la réponse sera "pas dans les  cases case1 ni case2") et "comment remplir cette case ?" pour une case différente de case1 et case2 (la réponse sera "pas avec valeur1 ni valeur2")


