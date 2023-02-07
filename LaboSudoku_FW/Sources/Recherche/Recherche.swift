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
    
    func coups(pour grilleAvecContenu: GrilleAvecContenu) -> Set<Coup> {
        var resultat = Set<Coup>()
        switch strategie {
        case .rechercheDeCasesPourValeur:
            for valeur in 1...9 {
                for zone in GrilleAvecContenu.lesZonesPourRechercheDeCases {
                    let focalisation = FocalisationValeurZone.avec(valeur: valeur, zone: zone)
                    if let uniqueCase = focalisation.uniqueCasePossible(pour: grilleAvecContenu) {
                        resultat.insert(Coup(uniqueCase, valeur))
                    }
                }
            }
        case .rechercheDeValeursPourCase:
            for cellule in GrilleAvecContenu.lesCases {
                let focalisation = FocalisationCellule(cellule: cellule)
                if let uniqueValeur = focalisation.uniqueValeurPossible(pour: grilleAvecContenu) {
                    resultat.insert(Coup(cellule, uniqueValeur))
                }
            }
        }
        return resultat
    }
    
    func premierCoup(pour grilleAvecContenu: GrilleAvecContenu) -> CoupAvecExplication? {
        var trouve = false
        switch strategie {
        case .rechercheDeCasesPourValeur:
            // TODO: On pourrait profiter de cette recherche pour rechercher les émetteurs secondaires et leur faire éliminer d'autres cases.
            for valeur in 1...9 {
                for zone in GrilleAvecContenu.lesZonesPourRechercheDeCases {
                    let focalisation = FocalisationValeurZone.avec(valeur: valeur, zone: zone)
                    if let uniqueCase = focalisation.uniqueCasePossible(pour: grilleAvecContenu) {
                        trouve = true
                        return CoupAvecExplication(coup: Coup(uniqueCase, valeur), focalisation: .valeurZone(focalisation))
                    }
                }
            }
        case .rechercheDeValeursPourCase:
            for cellule in GrilleAvecContenu.lesCases {
                let focalisation = FocalisationCellule(cellule: cellule)
                if let uniqueValeur = focalisation.uniqueValeurPossible(pour: grilleAvecContenu) {
                    trouve = true
                    return CoupAvecExplication(coup: Coup(cellule, uniqueValeur), focalisation: .cellule(focalisation))
                }
            }
        }
        if !trouve { return nil }
    }
    
    func premierePaireUneValeurDeuxCases(pour grilleAvecContenu: GrilleAvecContenu) -> Set<Case>? {
        var trouve = false
        switch strategie {
        case .rechercheDeValeursPourCase:
            return nil
        case .rechercheDeCasesPourValeur:
            for zone in GrilleAvecContenu.lesZonesPourRechercheDeCases {
                for valeur in 1...9 {
                    let focalisation = FocalisationValeurZone.avec(valeur: valeur, zone: zone)
                    if let paire = focalisation.uniquePairePossible(pour: grilleAvecContenu) {
                        trouve = true
                        return paire
                    }
                }
            }
        }
        if !trouve { return nil }
    }
    
    func pairesUneValeurDeuxCases(pour grilleAvecContenu: GrilleAvecContenu) -> Set<PaireUneValeurDeuxCases> {
        var ensemblePaires = Set<PaireUneValeurDeuxCases>()
        var ensembleAnnotations = Set<AnnotationPaireUneValeurDeuxCases>()
        switch strategie {
        case .rechercheDeValeursPourCase:
            // On ne cherche pas les paires de ce type par cette stratégie
            return []
        case .rechercheDeCasesPourValeur:
            for zone in GrilleAvecContenu.lesZonesPourRechercheDeCases {
                for valeur in 1...9 {
                    let focalisation = FocalisationValeurZone.avec(valeur: valeur, zone: zone)
                    if let paireDeCases = focalisation.uniquePairePossible(pour: grilleAvecContenu) {
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

public extension Recherche {
    
    func pairesDeuxValeursDeuxCases(pour grilleAvecContenu: GrilleAvecContenu) -> Set<PaireDeuxValeursDeuxCases> {
        
        let paires1 = pairesUneValeurDeuxCases(pour: grilleAvecContenu)
        // Indexation par les paires de cases -> valeurs
        var dico = [Set<Case>: Set<Int>]()
        for paire in paires1 {
            let (deuxCases, valeur) = (paire.paireDeCases, paire.valeur)
            if let dejaIndexe = dico[deuxCases] {
                dico[deuxCases] = dejaIndexe.union([valeur])
            } else {
                dico[deuxCases] = [valeur]
            }
        }
        // On ne retient que les paires de cases qui ont deux valeurs
        let avecDeuxValeurs = dico.filter { deuxCases, valeurs in
            valeurs.count == 2
        }
        return  avecDeuxValeurs.map { deuxCases, deuxValeurs in
            PaireDeuxValeursDeuxCases(paireDeCases: deuxCases, paireDeValeurs: deuxValeurs)
        }.ensemble
    }
}
