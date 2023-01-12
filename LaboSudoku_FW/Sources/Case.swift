//
//  CaseGrille.swift
//  EtudeSudokuGT
//
//  Created by Gérard Tisseau on 10/01/2023.
//

import Foundation

struct Case: Hashable, CustomStringConvertible, Codable {
    let ligne: Int
    let colonne: Int
    
    init(_ ligne: Int, _ colonne: Int) {
        self.ligne = ligne
        self.colonne = colonne
    }
    
    var description: String {
        "Case(\(ligne), \(colonne))"
    }
}
