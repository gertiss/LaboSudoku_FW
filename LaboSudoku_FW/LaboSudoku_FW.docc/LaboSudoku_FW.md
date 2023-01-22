# ``LaboSudoku_FW``

Un laboratoire d'expérimentation du Sudoku, pour découvrir, explorer, comprendre, apprendre.

Lors de la résolution, l'état de la grille et des connaissances sur cette grille est donné par un ensemble de faits du type :

Il y a une bijection de C (un ensemble de cases) vers V (un ensemble de valeurs).

Il peut se produire deux sortes d'événements : 

- la découverte d'un coup impossible : valeur(case) ≠ chiffre
- la découverte d'un coup obligé : valeur(case) = chiffre

Chacun de ces événements produit en réaction une mise à jour de la base de faits (on la spécialise, on la minimise). Chaque bijection peut se restreindre. Quand une bijection se restreint à un couple de singletons (case, valeur), alors c'est un coup obligé. Quand une bijection se restreint à un couple de paires, on peut en déduire des éliminations.

Une grille vide a 27 bijections de 9 cases vers 9 valeurs.
Chaque jeu d'un coup restreint les bijections des 3 zones auxquelles la case appartient : ligne, colonne, carré.

Une étape du raisonnement consiste à découvrir une bijection qu'on peut restreindre. On peut la découvrir en se focalisant sur un ensemble de cases (quelles sont les valeurs candidates dans cette région) ou sur un ensemble de valeurs (quelles sont les cases candidates pour ces valeurs)
