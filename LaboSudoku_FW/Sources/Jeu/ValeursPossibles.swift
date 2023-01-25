//
//  ValeursCandidates.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 16/01/2023.
//

import Foundation

// MARK: - Elimination de valeurs par rayonnement

// Quelles sont les valeurs possibles pour une case vide
// une fois qu'on a éliminé les valeurs impossibles à cause du rayonnement ?
// On doit examiner les 20 cases qui sont dans le champ du rayonnement.

extension Grille {

    /// Les valeurs qui restent possibles pour la case après élimination  des valeurs présentes dans sa ligne, sa cellule et son carré par le procédé du rayonnement. Si la case est occupée, on rend l'ensemble vide car la valeur n'est pas "manquante".
    /// C'est le procédé d'élimination directe par rayonnement.
    func valeursPossiblesPourRayonnement(_ cellule: Case) -> Set<Int> {
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
    
    /// On se focalise sur une case vide d'une zone, et on cherche les valeurs impossibles dans cette case
    func valeursElimineesParRayonnementOuPresentesDansZone<Zone: UneZone>(pour cellule: Case, dans zone: Zone) -> Set<Int> {
        let ensembleValeurs = Set<Int>(1...9)
        let valeursElimineesParRayonnement = ensembleValeurs.subtracting(valeursPossiblesPourRayonnement(cellule))
        let valeursPresentesDansZone = zone.lesCases.compactMap {
            valeur($0) }
            .ensemble
        return valeursElimineesParRayonnement.union(valeursPresentesDansZone)
    }
    
        
}
