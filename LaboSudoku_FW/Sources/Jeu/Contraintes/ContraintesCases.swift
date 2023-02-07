//
//  ContraintesCases.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 30/01/2023.
//

import Foundation

public extension Contrainte {
    
    /// Le plus petit ensemble de chiffres dont tout élément peut être contenu dans au moins une des cases de la zone pour la grilleAvecContenu donnée (au stade actuel du raisonnement, et qu'on peut découvrir avec des méthodes humaines).
    /// Cas particulier simple : s'il n'y a qu'une seule case, c'est l'ensemble des chiffres encore possibles dans la case.
    static func valeursPossibles(grilleAvecContenu: GrilleAvecContenu, zone: any UneZone, cases: Set<Case>) -> Set<Int> {
        fatalError("à implémenter")
    }
    
    /// Le plus grand ensemble de chiffres dont chaque élément n'est contenu dans aucune des cases de la zone pour la grilleAvecContenu donnée  (au stade actuel du raisonnement), et qu'on peut découvrir avec des méthodes humaines.
    /// Cas particulier simple : s'il n'y a qu'une seule case, c'est l'ensemble des chiffres impossibles pour la case.
    static func valeursImpossibles(grilleAvecContenu: GrilleAvecContenu, zone: any UneZone, cases: Set<Case>) -> Set<Int> {
        fatalError("à implémenter")
    }
}
