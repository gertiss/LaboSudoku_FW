//
//  CoupsPossibles.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 16/01/2023.
//

import Foundation

public extension Grille {
    
    /// Les coups avec les cellules vides qui n'ont plus que la valeur donnée comme seule valeur candidate
    func coupsUniqueValeurObliges(valeur: Int) -> Set<Coup> {
        var ensemble = Set<Coup>()
        for cellule in Grille.lesCases {
            let valeurs = valeursManquantesCandidates(cellule)
            if valeurs.count == 1 &&  valeurs.uniqueElement == valeur{
                ensemble.insert(Coup(cellule, valeur))
            }
        }
        return ensemble
    }
    
    /// Le seul coup possible pour une cellule vide qui n'a plus qu'une seule valeur candidate, nil sinon
    func coupUniqueValeurOblige(cellule: Case) -> Coup? {
        guard let valeur = valeursManquantesCandidates(cellule).uniqueValeur else {
            return nil
        }
        return Coup(cellule, valeur)
    }
    
    var coupsUniqueValeurObliges: Set<Coup> {
        var ensemble: Set<Coup> = []
        
        for valeur in 1...9 {
            ensemble = ensemble.union(coupsUniqueValeurObliges(valeur: valeur))
        }
        
        return ensemble
    }
    
}
