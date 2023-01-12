//
//  Colonne.swift
//  EtudeSudokuGT
//
//  Created by Gérard Tisseau on 10/01/2023.
//

import Foundation

public struct Colonne: UneZone, Codable {
    public let index: Int // de 0 à 8
    
    public init(_ index: Int) {
        self.index = index
    }
    
    /// Les 9 cases de la colonne
    public var lesCases: [Case] {
        (0...8).map { Case($0, index) }
    }
}
