//
//  CaseGrille.swift
//  EtudeSudokuGT
//
//  Created by Gérard Tisseau on 10/01/2023.
//

import Foundation

public struct Case: Hashable, CustomStringConvertible, Codable {
    public let ligne: Int
    public let colonne: Int
    
    public init(_ ligne: Int, _ colonne: Int) {
        self.ligne = ligne
        self.colonne = colonne
    }
    
    public var description: String {
        "Case(\(ligne), \(colonne))"
    }
}
