//
//  Coup.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 12/01/2023.
//

import Foundation

/// Un Coup est un singleton
public struct Coup: Testable {
    public var cellule: Case
    public var valeur: Int // de 1 à 9
    
    public init(_ cellule: Case, _ valeur: Int) {
        assert(valeur >= 1 && valeur <= 9)
        self.cellule = cellule
        self.valeur = valeur
    }
    
    public var description: String {
        "Coup(\(cellule), \(valeur))"
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
        case .valeurZone:
            return .rechercheDeCasesPourValeur
        case .cellule:
            return .rechercheDeValeursPourCase
        }
    }
    
    var explication: String {
        switch focalisation {
        case .valeurZone(let fValeurZone):
            return "\(coup.valeur) ? Dans \(fValeurZone.zone.nom) : \(coup.cellule.nom) = \(coup.valeur)"
        case .cellule(_):
            return "\(coup.cellule.nom) ? \(coup.valeur)"
        }
    }
}
