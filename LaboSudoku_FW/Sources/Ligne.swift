//
//  Ligne.swift
//  EtudeSudokuGT
//
//  Created by Gérard Tisseau on 10/01/2023.
//

import Foundation

public struct Ligne: UneZone {
    public let index: Int // de 0 à 8
    
    public init(_ index: Int) {
        assert(index >= 0 && index <= 8)
        self.index = index
    }

    /// Les 9 cases de la ligne
    public var lesCases: [Case] {
        (0...8).map { Case(index, $0) }
    }
    
    public var description: String {
        "Ligne(\(index))"
    }

}

public extension Ligne {
    
    var nom: String {
        return Grille.nomsLignes[index]
    }
    
    func texte(dans grille: Grille) -> String {
        let txtValeurs = (0...8)
            .map { co in
                let valeur = grille.valeur(Case(index, co))
                return valeur == 0 ? "·" : "\(valeur)"
            }
            .joined(separator: " ")
        
        return "\(Grille.nomsLignes[index]) \(txtValeurs)"

        
    }
}
