//
//  Carre.swift
//  EtudeSudokuGT
//
//  Created by Gérard Tisseau on 10/01/2023.
//

import Foundation

public struct Carre: UneZone {
    public var nom: String {
        let nomsBandesH = ["X", "Y", "Z"]
        let nomsBandesV = ["x", "y", "z"]
        return "le carré \(nomsBandesH[bandeH])\(nomsBandesV[bandeV])"
   }
    
    public var type: TypeZone = .carre

    public let bandeH: Int // de 0 à 2
    public let bandeV: Int // de 0 à 2
    
    public init(_ bandeH: Int, _ bandeV: Int) {
        assert(bandeH >= 0 && bandeH <= 2)
        assert(bandeV >= 0 && bandeV <= 2)
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
    
    public var rangeLignes: ClosedRange<Int> {
        (bandeH * 3)...(bandeH * 3 + 2)
    }
    
    public var rangeColonnes: ClosedRange<Int> {
        (bandeV * 3)...(bandeV * 3 + 2)
    }

}
