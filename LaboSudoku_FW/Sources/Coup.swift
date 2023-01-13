//
//  Coup.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 12/01/2023.
//

import Foundation

public struct Coup: UtilisableCommeAtome {
    public var laCase: Case
    public var valeur: Int // de 1 à 9
    
    public init(_ laCase: Case, _ valeur: Int) {
        assert(valeur >= 1 && valeur <= 9)
        self.laCase = laCase
        self.valeur = valeur
    }
    
    public var description: String {
        "Coup(\(laCase), \(valeur))"
    }
}
