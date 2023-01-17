//
//  ValeursCandidates.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 16/01/2023.
//

import Foundation


extension Grille {

    /// Les valeurs qui restent possibles pour la case après élimination  des valeurs présentes dans sa ligne, sa cellule et son carré. Si la case est occupée, on rend l'ensemble vide.
    func valeursManquantesCandidates(_ cellule: Case) -> Set<Int> {
        if !caseEstVide(cellule) {
            return []
        }
        var ensemble: Set<Int> = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        // Elimination de toutes les valeurs présentes dans la ligne
        Grille.ligne(cellule).lesCases.forEach {
            ensemble.remove(valeur($0))
        }

        // Elimination de toutes les valeurs présentes dans la colonne
        Grille.colonne(cellule).lesCases.forEach {
            ensemble.remove(valeur($0))
        }

        // Elimination de toutes les valeurs présentes dans le carré
        Grille.carre(cellule).lesCases.forEach {
            ensemble.remove(valeur($0))
        }
        return ensemble
    }
        
}
