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
    case rechercheDeCasesPourValeur
    case rechercheDeValeursPourCase
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
        case .rechercheDeCasesPourValeur:
            for zone in Grille.lesZonesPourRechercheDeCases {
                for valeur in 1...9 {
                    let focalisation = FocalisationValeurZone.avec(valeur: valeur, zone: zone)
                    if let uniqueCase = focalisation.uniqueCasePossible(pour: grille) {
                        trouve = true
                        return CoupAvecExplication(coup: Coup(uniqueCase, valeur), focalisation: .valeurZone(focalisation))
                    }
                }
            }
        case .rechercheDeValeursPourCase:
            for cellule in Grille.lesCases {
                let focalisation = FocalisationCellule(cellule: cellule)
                if let uniqueValeur = focalisation.uniqueValeurPossible(pour: grille) {
                    trouve = true
                    return CoupAvecExplication(coup: Coup(cellule, uniqueValeur), focalisation: .cellule(focalisation))
                }
            }
        }
        if !trouve { return nil }
    }
    
}
