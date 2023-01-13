//
//  CaseGrille.swift
//  EtudeSudokuGT
//
//  Created by Gérard Tisseau on 10/01/2023.
//

import Foundation

public struct Case: Hashable, CustomStringConvertible, Codable {
    public let ligne: Int // de 0 à 8
    public let colonne: Int // de 0 à 8
    
    public init(_ ligne: Int, _ colonne: Int) {
        assert(ligne >= 0 && ligne <= 8)
        assert(colonne >= 0 && colonne <= 8)
        self.ligne = ligne
        self.colonne = colonne
    }
    
    public var description: String {
        "Case(\(ligne), \(colonne))"
    }
}
