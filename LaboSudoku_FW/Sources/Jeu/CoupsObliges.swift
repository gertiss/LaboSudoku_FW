//
//  CoupsPossibles.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 16/01/2023.
//

import Foundation

public extension Grille {
    
    /// Les coups avec les cellules vides qui n'ont plus que la valeur donnée comme seule valeur candidate
    func coupsObliges(valeur: Int) -> Set<Coup> {
        Grille.lesCases
            .filter { caseEstVide($0)}
            .filter { valeursManquantesCandidates($0).count == 1 }
            .map { cellule in Coup(cellule, valeur)}
            .ensemble
    }
    
    /// Le seul coup possible pour une cellule vide qui n'a plus qu'une seule valeur candidate, nil sinon
    func coupOblige(cellule: Case) -> Coup? {
        guard let valeur = valeursManquantesCandidates(cellule).uniqueValeur else {
            return nil
        }
        return Coup(cellule, valeur)
    }
    
    var coupsObliges: Set<Coup> {
        var ensemble: Set<Coup> = []
        
        (1...9).forEach { valeur in
            ensemble = ensemble.union(coupsObliges(valeur: valeur))
        }
        Grille.lesCases.forEach { cellule in
            if let coup = coupOblige(cellule: cellule) {
                ensemble.insert(coup)
            }
        }
        return ensemble
    }
}
