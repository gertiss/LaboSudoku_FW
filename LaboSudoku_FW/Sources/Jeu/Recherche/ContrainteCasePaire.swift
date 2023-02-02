//
//  DicoCaseCouples.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 26/01/2023.
//

import Foundation


/// Représente une contrainte signifiant : la case donnée ne peut recevoir aucun autre chiffre que les deux de la paire.
public struct ContrainteCasePaire : Hashable, Codable {
    
    public var cellule: Case
    public var paireValeurs: Set<Int> // à deux éléments
    
    public init(cellule: Case, paireValeurs: Set<Int>) {
        self.cellule = cellule
        self.paireValeurs = paireValeurs
        assert(paireValeurs.count == 2)
    }
}

/// On suppose la case vide. On élimine toutes les valeurs provenant des émetteurs qui dans la zone couverte par le radar de la cellule.
public extension Grille {
    
    /// Quelles valeurs peut-on mettre dans la cellule ?
    func valeursCandidates(cellule: Case) -> Set<Int> {
        assert(caseEstVide(cellule))
        let ensembleCandidates: Set<Int> = Set(1...9)
        var ensembleValeursEmetteurs = Set<Int>()
        for n in 1...9 {
            for caseRadar in Grille.radar(cellule) {
                if caseEstOccupee(caseRadar) {
                    ensembleValeursEmetteurs.insert(n)
                }
            }
        }
        return ensembleCandidates.subtracting(ensembleValeursEmetteurs)
    }
    
    /// Où peut-on mettre la valeur dans la zone ?
    func cellulesCandidates<Zone: UneZone>(valeur: Int, dans zone: Zone) -> Set<Case> {
        var ensemble = Set<Case>()
        for cellule in zone.lesCases {
            let valeursCandidates = valeursCandidates(cellule: cellule)
            if valeursCandidates.contains(valeur) {
                ensemble.insert(cellule)
            }
        }
        return ensemble
    }
    
}
