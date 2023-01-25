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

et des événements dérivés :

- Dans telle zone, telle valeur ne peut aller que dans telle paire de cases.
- Dans telle zone, telle paire de valeurs ne peut aller que dans telle paire de cases, et cela crée une nouvelle bijection.

Chacun de ces événements produit en réaction une mise à jour de la base de faits (on la spécialise, on la minimise). Chaque bijection peut se restreindre. Quand une bijection se restreint à un couple de singletons (case, valeur), alors c'est un coup obligé. Quand une bijection se restreint à un couple de paires, on peut en déduire des éliminations.

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

Les principaux types de faits humainement détectables et mémorisables sont :

- valeur d'une case : telle case ne peut recevoir que telle valeur. Action: on écrit la valeur dans la case.
- annotation des valeurs candidates pour une case dans une zone. Cas particulier : une case, deux valeurs (telle case ne peut recevoir que ces deux valeurs). Action : on écrit ces valeurs avec un formalisme spécial dans la case.
- annotation de cases candidates pour une valeur dans une zone. Cas particulier : une valeur, deux cases (telle valeur ne peut aller que dans une de ces deux cases). Action : on écrit cette valeur avec un formalisme spécial en lien avec les deux cases.
- annotation de bijection dans une zone. Cas particulier : deux cases, deux valeurs (il y a une bijection entre ces deux cases et ces deux valeurs). Action : on écrit ces deux valeurs avec un formalisme spécial en lien avec ces deux cases.

Le fait "valeur d'une case" n'est qu'un cas particulier du fait "bijection" : il y a une bijection d'une case vers une valeur dans chacune des 3 zones qui contient la case.

Ce qu'il y a d'écrit dans une grille constitue une base de faits. Le but est d'arriver à résoudre le problème en se limitant à cette base de faits. Toute étape du jeu modifie la base de faits.

La forme la plus générale d'un fait est d'un des deux types suivants (sous forme de prédicats) :

    ValeursCandidates(cases, chiffres)
    CasesCandidates(zone, cases, chiffres)

`ValeursCandidates(cases, chiffres)` veut dire : l'ensemble des valeurs des cases est inclus dans l'ensemble des chiffres. 

`CasesCandidates(zone, cases, chiffres)` veut dire : l'ensemble des antécédents des chiffres dans la zone est l'ensemble des cases. Exemple : l'ensemble des antécédents de {1, 2} dans le carré (haut, gauche) est {Aa, Bb}. Cet exemple est le cas d'une sous-bijection. 

Le fait que les cases appartiennent à une même zone implique qu'il y a une injection de l'ensemble des cases dans l'ensemble des chiffres, d'où le cas particulier : quand le nombre de cases est égal au nombre de chiffres, il s'agit d'une bijection.

Mais un joueur humain se limite aux cas où "cases" et "valeurs" ne comporte qu'un ou deux éléments.


