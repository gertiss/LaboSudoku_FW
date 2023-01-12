//
//  Carre.swift
//  EtudeSudokuGT
//
//  Created by Gérard Tisseau on 10/01/2023.
//

import Foundation

struct Carre: Zone, Hashable, CustomStringConvertible, Codable {
    let bandeH: Int
    let bandeV: Int
    
    init(_ bandeH: Int, _ bandeV: Int) {
        self.bandeH = bandeH
        self.bandeV = bandeV
    }
    
    var description: String {
        "Carre(\(bandeH), \(bandeV))"
    }
    
    /// Les 9 cases du carré
    var lesCases: [Case] {
        var liste = [Case]()
        for dl in 0...2 {
            for dc in 0...2 {
                liste.append(Case(bandeH * 3 + dl, bandeV * 3 + dc))
            }
        }
        return liste
    }
}
