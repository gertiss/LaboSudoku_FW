//
//  CasesCandidates.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 16/01/2023.
//

import Foundation

// MARK: - Cases interdites

public extension Grille {
    
    /// La réunion de tous les "rayons" envoyés par les cases contenant la valeur
    /// Chaque case émettrice élimine 20 autres cases.
    /// On ne compte pas les cases émettrices comme interdites (après tout, elles ont la bonne valeur).
    func casesElimineesParRayonnement(pour valeur: Int) -> Set<Case> {
        var ensemble = Set<Case>()
        let casesEmettrices = casesRemplies(avec: valeur)
        for cellule in casesEmettrices {
            ensemble = ensemble.union(Grille.ligne(cellule).lesCases)
            ensemble = ensemble.union(Grille.colonne(cellule).lesCases)
            ensemble = ensemble.union(Grille.carre(cellule).lesCases)
        }
        return ensemble.subtracting(casesEmettrices)
    }
    
    /// Les coups interdits pour la valeur, par carré.
    /// Pour chaque carré, la liste des coups interdits dans le carré
    func coupsInterditsParCarre(pour valeur: Int) -> [Carre: [Coup]] {
        let dicoCases = casesInterditesParCarre(pour: valeur)
        return dicoCases.mapValues { ensemble in
            ensemble.map { cellule in
                Coup(cellule, valeur)
            }
        }
    }
    
    /// Les cases interdites pour la valeur, regroupées par carrés
    /// "interdite" signifie : éliminée par rayonnement ou déjà occupée
    func casesInterditesParCarre(pour valeur: Int) -> [Carre: Set<Case>] {
        let casesInterditesDansGrille = casesElimineesParRayonnement(pour: valeur)
        var dico = [Carre: Set<Case>]()
        
        Grille.lesCarres.forEach { carre in
            carre.lesCases.forEach { cellule in
                if casesInterditesDansGrille.contains(cellule) || !caseEstVide(cellule) {
                    dico.ajouter(cellule, a: carre)
                }
            }
        }
        return dico
    }
    
    /// Pour chaque carré, le nombre de cases impossibles pour la valeur
    /// "impossible" signifie : éliminée par les rayons ou déjà occupée
    func nombreDeCasesImpossiblesParCarre(pour valeur: Int) -> [Carre: Int] {
        var dico = [Carre: Int]()
        casesInterditesParCarre(pour: valeur)
            .forEach { carre, cellules in
                dico[carre] = cellules.count
            }
        
        return dico
    }
    
    /// Les carres où il ne reste plus qu'une case candidate pour la valeur,
    /// c'est-à-dire avec 8 cases interdites
    func carresCibles(pour valeur: Int) -> [Carre] {
        nombreDeCasesImpossiblesParCarre(pour: valeur)
            .filter { _, n in n == 8 }
            .keys.map { $0 }
    }
    
    /// Les cases vides où on peut placer la valeur 1
    func casesPossiblesParCarre(pour valeur: Int) -> [Carre: Set<Case>] {
        var dico = [Carre: Set<Case>]()
        for (carre, interdites) in casesInterditesParCarre(pour: valeur) {
            let possibles = carre.lesCases.ensemble.subtracting(interdites)
            dico[carre] = possibles
        }
        return dico
    }
    
    func casesObligeesParRayons(pour valeur: Int) -> [Case] {
        let casesObligeesParCarre = casesPossiblesParCarre(pour: valeur).filter { (_, cellules) in
            cellules.count == 1
        }
        var liste = [Case]()
        for (_, cellules) in casesObligeesParCarre {
            liste.append(cellules.uniqueElement)
        }
        return liste
    }
    
    func casesObligeesParNeuviemeValeur(pour valeur: Int) -> [Case] {
        var liste = [Case]()
        for cellule in Grille.lesCases {
            let valeurs = valeursManquantesCandidates(cellule)
            if valeurs.count == 1 &&  valeurs.uniqueElement == valeur{
                liste.append(cellule)
            }
        }
        return liste
    }
}

