//
//  Ligne.swift
//  EtudeSudokuGT
//
//  Created by Gérard Tisseau on 10/01/2023.
//

import Foundation

public struct Ligne: UneZone, Codable {
    public let index: Int // de 0 à 8
    
    public init(_ index: Int) {
        self.index = index
    }

    /// Les 9 cases de la ligne
    public var lesCases: [Case] {
        (0...8).map { Case(index, $0) }
    }

}
