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
public enum FocalisationZoneValeur {
    case carre(Carre, Int)
    case ligne(Ligne, Int)
    case colonne(Colonne, Int)
    
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
    
    /// Les cases de la zone
    public var cases: Set<Case> {
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
    public func casesInterdites(pour grille: Grille) -> Set<Case> {
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
    public func casesPossibles(pour grille: Grille) -> Set<Case> {
        cases.subtracting(casesInterdites(pour: grille))
    }
}

/// On se focalise sur une zone et une case de cette zone.
/// La question est : quelles sont les valeurs interdites/possibles pour cette case ?
public enum FocalisationZoneCase {
    case carre(Carre, Case)
    case ligne(Ligne, Case)
    case colonne(Colonne, Case)
    
    /// Les cases de la zone
    public var cases: Set<Case> {
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
    public var cellule: Case {
        switch self {
        case .carre(_, let cellule):
            return cellule
        case .ligne(_, let cellule):
            return cellule
        case .colonne(_, let cellule):
            return cellule
        }
    }
    
    /// Les valeurs impossibles pour la case dans la zone, pour une grille donnée
    public func valeursInterdites(pour grille: Grille) -> Set<Int> {
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
   public func valeursPossibles(pour grille: Grille) -> Set<Int> {
        Set<Int>(1...9).subtracting(valeursInterdites(pour: grille))
    }

    
}
