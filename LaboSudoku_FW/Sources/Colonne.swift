//
//  Colonne.swift
//  EtudeSudokuGT
//
//  Created by Gérard Tisseau on 10/01/2023.
//

import Foundation

struct Colonne: Zone, Codable {
    let index: Int // de 0 à 8
    
    init(_ index: Int) {
        self.index = index
    }
    
    /// Les 9 cases de la colonne
    var lesCases: [Case] {
        (0...8).map { Case($0, index) }
    }
}
