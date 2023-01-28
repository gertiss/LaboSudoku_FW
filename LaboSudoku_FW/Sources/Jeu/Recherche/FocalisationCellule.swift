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
    
    /// Les valeurs impossibles pour la case dans la zone, pour une grille donnée
    /// Ce sont les valeurs qui sont visibles dans les "radars" de la cellule.
    func valeursInterdites(pour grille: Grille) -> Set<Int> {
        var ensemble = Set<Int>()
        for zone in Grille.lesZones {
            ensemble = ensemble.union(grille.valeursElimineesParRayonnementOuPresentesDansZone(pour: cellule, dans: zone))
        }
        return ensemble
    }
    
    /// Les valeurs possibles pour la case dans la zone, pour une grille donnée
    func valeursPossibles(pour grille: Grille) -> Set<Int> {
        Set<Int>(1...9).subtracting(valeursInterdites(pour: grille))
    }
    
    /// On retourne une valeur si c'est la seule possible pour la grille, nil sinon
    func uniqueValeurPossible(pour grille: Grille) -> Int? {
        valeursPossibles(pour: grille).uniqueValeur
    }

    
}
