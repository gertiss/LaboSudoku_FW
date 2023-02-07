//
//  ContraintesValeurs.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 30/01/2023.
//

import Foundation

public extension Contrainte {
    
    /// Le plus petit ensemble de cases de la `zone` dont chaque case contient au moins une des `valeurs`.
    /// Du moins ce qu'on peut en dire au stade actuel du raisonnement.
    /// C'est le "conteneur minimum" de cet ensemble de valeurs.
    /// Cas particulier : s'il n'y a qu'une valeur, c'est l'ensemble des cases de la zone possibles pour cette valeur.
    static func casesPossibles(grilleAvecContenu: GrilleAvecContenu, zone: any UneZone, valeurs: Set<Int>) -> Set<Case> {
        fatalError("à implémenter")
    }
    
    /// Le plus grand ensemble de cases de la `zone` qui ne contient aucune des `valeurs`.
    /// Du moins c'est ce qu'on en sait au stade actuel du raisonnement.
    /// Cas particulier : s'il n'y a qu'une valeur, c'est l'ensemble des cases de la zone impossibles pour cette valeur.
    static func casesImpossibles(grilleAvecContenu: GrilleAvecContenu, zone: any UneZone, valeurs: Set<Int>) -> Set<Case> {
        fatalError("à implémenter")
    }

}
