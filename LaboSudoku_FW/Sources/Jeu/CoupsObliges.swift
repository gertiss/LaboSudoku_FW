//
//  CoupsPossibles.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 16/01/2023.
//

import Foundation

// MARK: - Par rayonnement à partir des valeurs

public extension Grille {
    
    /// Tous les coups obligés trouvés par rayonnement direct pour toutes les valeurs
    /// Focalisation : pour chaque valeur, pour chaque zone, chercher la neuvième case
    var coupsObligesApresEliminationDirecteParRayonnement: Set<Coup> {
        var ensemble = Set<Coup>()
        for valeur in 1...9 {
            let cellules = casesObligeesApresEliminationDirecteParRayonnement(pour: valeur)
            ensemble = ensemble.union(cellules.map { Coup($0, valeur) }.ensemble)
        }
        return ensemble
    }
}


// MARK: - Par unique valeur possible dans une case

public extension Grille {
    
    
    /// Tous les coups obligés trouvés par la règle 8 valeurs impossibles dans une zone => neuvième obligée
    /// Focalisation : pour chaque zone, pour chaque case, chercher la neuvième valeur
    var coupsObligesParUniqueValeurPossible: Set<Coup> {
        var ensemble: Set<Coup> = []
        
        for zone in Grille.lesZones {
            ensemble = ensemble.union(coupsObligesParUniqueValeurPossible(dans: zone))
        }
        
        return ensemble
    }
    
    
    /// Le seul coup possible pour une cellule vide qui n'a plus qu'une seule valeur candidate, nil sinon
    func coupObligeParUniqueValeurPossible(dans cellule: Case) -> Coup? {
        guard let valeur = valeursPossiblesPourRayonnement(cellule).uniqueValeur else {
            return nil
        }
        return Coup(cellule, valeur)
    }
    
    
    
    /// Les seuls coups possibles dans une zone en cherchant les cases qui n'ont plus qu'une seule valeur candidate
    func coupsObligesParUniqueValeurPossible<Z: UneZone>(dans zone: Z) -> Set<Coup> {
        var ensemble = Set<Coup>()
        for cellule in zone.lesCases {
            if let coup = coupObligeParUniqueValeurPossible(dans: cellule) {
                ensemble.insert(coup)
            }
        }
        return ensemble
    }
}


    
    

