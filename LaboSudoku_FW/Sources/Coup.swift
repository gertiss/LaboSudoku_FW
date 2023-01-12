//
//  Coup.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 12/01/2023.
//

import Foundation

public struct Coup {
    public var laCase: Case
    public var valeur: Int
    
    public init(_ laCase: Case, _ valeur: Int) {
        self.laCase = laCase
        self.valeur = valeur
    }
}
