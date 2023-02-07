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
    
    
    /// Les valeurs possibles pour la case dans la zone, pour une grilleAvecContenu donnée
    func valeursPossibles(pour grilleAvecContenu: GrilleAvecContenu) -> Set<Int> {
             let interdites = GrilleAvecContenu.radar(cellule)
                .filter { grilleAvecContenu.caseEstOccupee($0) }
                .map { grilleAvecContenu.valeur($0) }
                .ensemble
        return Set(1...9).subtracting(interdites)
    }
    
    /// On retourne une valeur si c'est la seule possible pour la grilleAvecContenu, nil sinon
    func uniqueValeurPossible(pour grilleAvecContenu: GrilleAvecContenu) -> Int? {
        if grilleAvecContenu.caseEstOccupee(cellule) { return nil }
        return valeursPossibles(pour: grilleAvecContenu).uniqueValeur
    }
    
    func uniquePairePossible(pour grilleAvecContenu: GrilleAvecContenu) -> Set<Int>? {
        let valeursCandidates = valeursPossibles(pour: grilleAvecContenu)
        return valeursCandidates.count == 2 ? valeursCandidates : nil
    }

    
}
