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
            // TODO: Il faudrait profiter de cette recherche pour rechercher les émetteurs secondaires et leur faire éliminer d'autres cases.
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
    
    func premierePaireDeCases(pour grille: Grille) -> Set<Case>? {
        var trouve = false
        switch strategie {
        case .rechercheDeValeursPourCase:
            return nil
        case .rechercheDeCasesPourValeur:
            for zone in Grille.lesZonesPourRechercheDeCases {
                for valeur in 1...9 {
                    let focalisation = FocalisationValeurZone.avec(valeur: valeur, zone: zone)
                    if let paire = focalisation.uniquePairePossible(pour: grille) {
                        trouve = true
                        return paire
                    }
                }
            }
        }
        if !trouve { return nil }
    }
    
    func pairesDeCases(pour grille: Grille) -> Set<PaireUneValeurDeuxCases> {
        var ensemblePaires = Set<PaireUneValeurDeuxCases>()
        var ensembleAnnotations = Set<AnnotationPaireUneValeurDeuxCases>()
        switch strategie {
        case .rechercheDeValeursPourCase:
            // On ne cherche pas les paires de ce type par cette stratégie
            return []
        case .rechercheDeCasesPourValeur:
            for zone in Grille.lesZonesPourRechercheDeCases {
                for valeur in 1...9 {
                    let focalisation = FocalisationValeurZone.avec(valeur: valeur, zone: zone)
                    if let paireDeCases = focalisation.uniquePairePossible(pour: grille) {
                        let annotation = AnnotationPaireUneValeurDeuxCases(valeur: valeur, paireDeCases: paireDeCases)
                        if !ensembleAnnotations.contains(annotation) {
                            ensemblePaires.insert(PaireUneValeurDeuxCases(paireDeCases: paireDeCases, focalisation: focalisation))
                            ensembleAnnotations.insert(annotation)
                        }
                    }
                }
            }
        }
        let liste: [PaireUneValeurDeuxCases] = ensemblePaires.map { $0 }
        let resultat =  liste.sorted { paire1, paire2 in
            paire1.valeur <= paire2.valeur
        }.ensemble
        return resultat
    }
    
    
}
