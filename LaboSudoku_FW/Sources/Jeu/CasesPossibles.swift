//
//  CasesCandidates.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 16/01/2023.
//

import Foundation

// MARK: - Elimination de cases par rayonnement

/*
 Quelles sont les cases vides possibles pour une valeur donnée une fois qu'on a éliminé les cases impossibles à cause du rayonnement ?
 */

public extension Grille {
    
    /// L'ensemble des 20 cases éliminées par rayonnement issu de l'émetteur
    func casesElimineesParRayonnement(par emetteur: Case) -> Set<Case> {
        var ensemble = Set<Case>()
        ensemble = ensemble.union(Grille.ligne(emetteur).lesCases)
        ensemble = ensemble.union(Grille.colonne(emetteur).lesCases)
        ensemble = ensemble.union(Grille.carre(emetteur).lesCases)
        return ensemble.subtracting([emetteur])
    }
    
    /// La réunion de tous les "rayons" envoyés par toutes  les cases "émettrices" contenant la valeur.
    /// Chaque case émettrice élimine 20 autres cases.
    /// On ne compte pas les cases émettrices comme éliminées (après tout, elles ont la bonne valeur).
    func casesElimineesParRayonnement(pour valeur: Int) -> Set<Case> {
        var ensemble = Set<Case>()
        let emetteurs = casesRemplies(avec: valeur)
        for emetteur in emetteurs {
            ensemble = ensemble.union(casesElimineesParRayonnement(par: emetteur))
        }
        return ensemble
    }
}

// MARK: - Recherche par valeur et par zone

public extension Grille {
    
    func casesElimineesDirectementParRayonnementOuOccupees<Zone: UneZone>(pour valeur: Int, dans zone: Zone) -> Set<Case> {
        let casesInterditesDansGrille = casesElimineesParRayonnement(pour: valeur)
        return zone.lesCases.filter { cellule in
            casesInterditesDansGrille.contains(cellule) || caseEstOccupee(cellule)
        }.ensemble
    }
    
    /// Où peut-on placer la valeur dans la zone ? En raisonnant uniquement par élimination directe.
    func casesPossiblesApresEliminationDirecteParRayonnement<Zone: UneZone>(pour valeur: Int, dans zone: Zone) -> Set<Case> {
        zone.lesCases.ensemble.subtracting(casesElimineesDirectementParRayonnementOuOccupees(pour: valeur, dans: zone))
    }
    
    /// Recherche d'un singleton obtenu par élimination directe par rayonnement
    func caseObligeeApresEliminationDirecteParRayonnement<Zone: UneZone>(pour valeur: Int, dans zone: Zone) -> Case? {
        casesPossiblesApresEliminationDirecteParRayonnement(pour: valeur, dans: zone).uniqueValeur
    }
    
}

// MARK: -  Recherche globale dans la grille

public extension Grille {
    
    /// Les cases qu'on peut déterminer uniquement par la stratégie d'élimination directe après rayonnement.
    /// Focalisation par valeur
    func casesObligeesApresEliminationDirecteParRayonnement(pour valeur: Int) -> Set<Case> {
        Grille.lesZones.compactMap { zone in
            caseObligeeApresEliminationDirecteParRayonnement(pour: valeur, dans: zone)
        }.ensemble
    }
    
}

