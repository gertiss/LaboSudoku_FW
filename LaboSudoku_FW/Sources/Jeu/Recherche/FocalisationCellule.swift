//
//  FocalisationZoneCase.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 23/01/2023.
//

import Foundation

/// La question est : quelles sont les valeurs interdites/possibles pour cette case ?
/// Dire que "v est Interdite" signifie que la case est vide et dans le champ d'un émetteur de v ou bien occupée avec une valeur différente de v.
/// "possible" est le contraire de "interdite".
public struct FocalisationCellule: Hashable, Codable {
    var cellule: Case
    
    public init(cellule: Case) {
        self.cellule = cellule
    }
}

public extension FocalisationCellule {
    
    
    /// Les valeurs possibles pour la case dans la zone, pour une grille donnée
    func valeursPossibles(pour grille: Grille) -> Set<Int> {
             let interdites = Grille.radar(cellule)
                .filter { grille.caseEstOccupee($0) }
                .map { grille.valeur($0) }
                .ensemble
        return Set(1...9).subtracting(interdites)
    }
    
    /// On retourne une valeur si c'est la seule possible pour la grille, nil sinon
    func uniqueValeurPossible(pour grille: Grille) -> Int? {
        if grille.caseEstOccupee(cellule) { return nil }
        return valeursPossibles(pour: grille).uniqueValeur
    }
    
    func uniquePairePossible(pour grille: Grille) -> Set<Int>? {
        let valeursCandidates = valeursPossibles(pour: grille)
        return valeursCandidates.count == 2 ? valeursCandidates : nil
    }

    
}
