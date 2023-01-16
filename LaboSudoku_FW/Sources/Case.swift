//
//  CaseGrille.swift
//  EtudeSudokuGT
//
//  Created by Gérard Tisseau on 10/01/2023.
//

import Foundation

public struct Case: Hashable, CustomStringConvertible, Codable {
    public let indexLigne: Int // de 0 à 8
    public let indexColonne: Int // de 0 à 8
    
    public init(_ indexLigne: Int, _ indexColonne: Int) {
        assert(indexLigne >= 0 && indexLigne <= 8)
        assert(indexColonne >= 0 && indexColonne <= 8)
        self.indexLigne = indexLigne
        self.indexColonne = indexColonne
    }
    
    public var description: String {
        "Case(\(indexLigne), \(indexColonne))"
    }
}

