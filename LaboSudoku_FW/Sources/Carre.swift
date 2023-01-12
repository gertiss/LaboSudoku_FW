//
//  Carre.swift
//  EtudeSudokuGT
//
//  Created by Gérard Tisseau on 10/01/2023.
//

import Foundation

public struct Carre: UneZone, Hashable, CustomStringConvertible, Codable {
    public let bandeH: Int
    public let bandeV: Int
    
    public init(_ bandeH: Int, _ bandeV: Int) {
        self.bandeH = bandeH
        self.bandeV = bandeV
    }
    
    public var description: String {
        "Carre(\(bandeH), \(bandeV))"
    }
    
    /// Les 9 cases du carré
    public var lesCases: [Case] {
        var liste = [Case]()
        for dl in 0...2 {
            for dc in 0...2 {
                liste.append(Case(bandeH * 3 + dl, bandeV * 3 + dc))
            }
        }
        return liste
    }
}
