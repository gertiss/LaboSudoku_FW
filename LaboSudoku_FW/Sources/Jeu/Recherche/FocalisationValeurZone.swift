//
//  Jeu.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 22/01/2023.
//

import Foundation

/// La question  est : quelles sont las cases interdites/possibles pour cette valeur dans cette zone ?
/// "Interdite" signifie : vide et dans le champ d'un émetteur de la valeur.
/// "possible" est le contraire de "interdite".
public enum FocalisationValeurZone: Hashable, Codable {
    case carre(Carre, Int)
    case ligne(Ligne, Int)
    case colonne(Colonne, Int)
    
    /// Fonction créatrice d'instances
    public static func avec<Zone: UneZone>(valeur: Int, zone: Zone) -> FocalisationValeurZone {
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


public extension FocalisationValeurZone {
    
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
    
    /// Les cases interdites dans la zone pour la valeur, dans une grille donnée.
    /// "Interdite" signifie : vide et dans le champ d'un émetteur de la valeur.
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
    
    /// Les cases possibles dans la zone pour la valeur, dans une grille donnée.
    func casesPossibles(pour grille: Grille) -> Set<Case> {
        cases.subtracting(casesInterdites(pour: grille))
    }
    
    /// On retourne une case si c'est la seule possible pour la grille, nil sinon
    func uniqueCasePossible(pour grille: Grille) -> Case? {
        casesPossibles(pour: grille).uniqueValeur
    }
    
    func uniquePairePossible(pour grille: Grille) -> Set<Case>? {
        let casesCandidates = casesPossibles(pour: grille)
        return casesCandidates.count == 2 ? casesCandidates : nil
    }
    
}



