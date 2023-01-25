//
//  Strategie.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 22/01/2023.
//

import Foundation

/*
 Recherche de solution suivant une stratégie
 */

public enum Strategie: Codable, Hashable {
    case eliminationCases
    case eliminationValeurs
}

/// On cherche des coups possibles avec une stratégie
public struct Recherche: Hashable {
    public var strategie: Strategie
    
    public init(strategie: Strategie) {
        self.strategie = strategie
    }
}

public extension Recherche {
    func premierCoup(pour grille: Grille) -> CoupAvecExplication? {
        var trouve = false
        switch strategie {
        case .eliminationCases:
            for zone in Grille.lesZonesPourEliminationValeurs {
                for valeur in 1...9 {
                    let focalisation = FocalisationZoneValeur.avec(zone: zone, valeur: valeur)
                    if let uniqueCase = focalisation.uniqueCasePossible(pour: grille) {
                        trouve = true
                        return CoupAvecExplication(coup: Coup(uniqueCase, valeur), focalisation: .zoneValeur(focalisation))
                    }
                }
            }
        case .eliminationValeurs:
            for zone in Grille.lesZonesPourEliminationCases {
                for cellule in zone.lesCases {
                    let focalisation = FocalisationZoneCase.avec(zone: zone, cellule: cellule)
                    if let uniqueValeur = focalisation.uniqueValeurPossible(pour: grille) {
                        trouve = true
                        return CoupAvecExplication(coup: Coup(cellule, uniqueValeur), focalisation: .zoneCase(focalisation))
                    }
                }
            }
        }
        if !trouve { return nil }
    }
}

/// Un coup obtenu par .eliminationCases provient d'une FocalisationZoneValeur pour une zone qui contient la case.
/// Un coup obtenu par .eliminationValeurs provient d'une FocalisationZoneCase pour une zone qui contient la case.
