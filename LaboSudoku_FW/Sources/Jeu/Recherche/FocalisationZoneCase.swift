//
//  FocalisationZoneCase.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 23/01/2023.
//

import Foundation

/// On se focalise sur une zone et une case de cette zone.
/// La question est : quelles sont les valeurs interdites/possibles pour cette case ?
public enum FocalisationZoneCase: Hashable, Codable {
    case carre(Carre, Case)
    case ligne(Ligne, Case)
    case colonne(Colonne, Case)
    
    public static func avec<Zone: UneZone>(zone: Zone, cellule: Case) -> FocalisationZoneCase {
        switch zone.type {
        case .carre:
            return .carre(zone as! Carre, cellule)
        case .ligne:
            return .ligne(zone as! Ligne, cellule)
        case .colonne:
            return .colonne(zone as! Colonne, cellule)
        }
    }

}

public extension FocalisationZoneCase {
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
    /// La case sur laquelle on se focalise
    var cellule: Case {
        switch self {
        case .carre(_, let cellule):
            return cellule
        case .ligne(_, let cellule):
            return cellule
        case .colonne(_, let cellule):
            return cellule
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
    
    
    /// Les valeurs impossibles pour la case dans la zone, pour une grille donnée
    func valeursInterdites(pour grille: Grille) -> Set<Int> {
        switch self {
        case .carre(let carre, _):
            return grille.valeursElimineesParRayonnementOuPresentesDansZone(pour: cellule, dans: carre)
        case .ligne(let ligne, _):
            return grille.valeursElimineesParRayonnementOuPresentesDansZone(pour: cellule, dans: ligne)
        case .colonne(let colonne, _):
            return grille.valeursElimineesParRayonnementOuPresentesDansZone(pour: cellule, dans: colonne)
        }
    }
    
    /// Les valeurs possibles pour la case dans la zone, pour une grille donnée
    func valeursPossibles(pour grille: Grille) -> Set<Int> {
        Set<Int>(1...9).subtracting(valeursInterdites(pour: grille))
    }
    
    func uniqueValeurPossible(pour grille: Grille) -> Int? {
        valeursPossibles(pour: grille).uniqueValeur
    }

    
}
