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

public struct CoupAvecExplication: Hashable, Codable {
    public var coup: Coup
    public var focalisation: Focalisation
    
    public init(coup: Coup, focalisation: Focalisation) {
        self.coup = coup
        self.focalisation = focalisation
    }
}

public extension CoupAvecExplication {
    
    var strategie: Strategie {
        switch focalisation {
        case .zoneValeur:
            return .eliminationCases
        case .zoneCase:
            return .eliminationValeurs
        }
    }
    
    var explication: String {
        switch focalisation {
        case .zoneValeur(_):
            return "La valeur \(coup.valeur) ne peut aller que dans la case \(coup.laCase.nom) (9ème case)"
        case .zoneCase(_):
            return "La case \(coup.laCase.nom) ne peut contenir que la valeur \(coup.valeur) (9ème valeur)"
        }
    }
}
