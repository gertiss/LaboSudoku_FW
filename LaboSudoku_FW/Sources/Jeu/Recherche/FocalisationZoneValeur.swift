//
//  Jeu.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 22/01/2023.
//

import Foundation

/// Une focalisation par rayonnement se focalise sur une zone et une valeur,
/// de manière à appliquer l'élimination par rayonnement.
/// La question  est : quelles sont las cases interdites/possibles par rayonnement pour cette valeur dans cette zone ?
public enum FocalisationZoneValeur: Hashable, Codable {
    case carre(Carre, Int)
    case ligne(Ligne, Int)
    case colonne(Colonne, Int)
    
    public static func avec<Zone: UneZone>(zone: Zone, valeur: Int) -> FocalisationZoneValeur {
        switch zone.type {
        case .carre:
            return .carre(zone as! Carre, valeur)
        case .ligne:
            return .ligne(zone as! Ligne, valeur)
        case .colonne:
            return .colonne(zone as! Colonne, valeur)
        }
    }
}


public extension FocalisationZoneValeur {
    
    /// La valeur sur laquelle on se focalise
    var valeur: Int {
        switch self {
        case .carre(_, let int):
            return int
        case .ligne(_, let int):
            return int
        case .colonne(_, let int):
            return int
        }
    }
    
    /// La zone sur laquelle on se focalise
    var zone: any UneZone {
        switch self {
        case .carre(let carre, _):
            return carre
        case .ligne(let ligne, _):
            return ligne
        case .colonne(let colonne, _):
            return colonne
        }
    }
    
    /// Les cases de la zone
    var cases: Set<Case> {
        switch self {
        case .carre(let carre, _):
            return carre.lesCases.ensemble
        case .ligne(let ligne, _):
            return ligne.lesCases.ensemble
        case .colonne(let colonne, _):
            return colonne.lesCases.ensemble
        }
    }
    
    /// Les cases interdites dans la zone pour la valeur, dans une grille donnée
    func casesInterdites(pour grille: Grille) -> Set<Case> {
        switch self {
        case .carre(let carre, let int):
            return grille.casesElimineesDirectementParRayonnementOuOccupees(pour: int, dans: carre)
        case .ligne(let ligne, let int):
            return grille.casesElimineesDirectementParRayonnementOuOccupees(pour: int, dans: ligne)
        case .colonne(let colonne, let int):
            return grille.casesElimineesDirectementParRayonnementOuOccupees(pour: int, dans: colonne)
        }
    }
    
    /// Les cases possibles dans la zone pour la valeur, dans une grille donnée
    func casesPossibles(pour grille: Grille) -> Set<Case> {
        cases.subtracting(casesInterdites(pour: grille))
    }
    
    func uniqueCasePossible(pour grille: Grille) -> Case? {
        casesPossibles(pour: grille).uniqueValeur
    }

}



