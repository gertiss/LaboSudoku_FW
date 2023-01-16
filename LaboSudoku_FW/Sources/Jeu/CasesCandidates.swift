//
//  CasesCandidates.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 16/01/2023.
//

import Foundation

extension Grille {
    
    /// Toutes les cases où la valeur est encore candidate
    func casesCandidates(_ valeur: Int) -> [Case] {
        Grille.lesCases.filter { valeursCandidates($0).contains(valeur) }
    }
    
    /// Les cases qui n'ont plus que la valeur comme unique valeur candidate
    func casesObligees(_ valeur: Int) -> [Case] {
        casesCandidates(valeur).filter { valeursCandidates($0).count == 1 }
    }
    
    func casesCandidates(pour valeur: Int, dans carre: Carre) -> [Case] {
        carre.lesCases.filter { valeursCandidates($0).contains(valeur) }
    }
    
    func casesVidesInterdites(pour valeur: Int) -> Set<Case> {
        var ensemble = Set<Case>()
        let casesEmettrices = casesRemplies(avec: valeur)
        for cellule in casesEmettrices {
            ensemble = ensemble.union(Ligne(cellule.indexLigne).lesCases)
            ensemble = ensemble.union(Colonne(cellule.indexColonne).lesCases)
            ensemble = ensemble.union(Grille.carre(cellule).lesCases)
        }
        return ensemble.subtracting(casesEmettrices)
    }
    
    func casesVidesInterditesParCarre(pour valeur: Int) -> [Carre: Set<Case>] {
        let casesVidesInterditesDansGrille = casesVidesInterdites(pour: valeur)
        var dico = [Carre: Set<Case>]()
        
        Grille.lesCarres.forEach { carre in
            let casesDuCarre = carre.lesCases
            casesDuCarre.forEach { caseDuCarre in
                if casesVidesInterditesDansGrille.contains(caseDuCarre) {
                    // on ajoute caseDuCarre à dico[carre]
                    if var ensemble = dico[carre] {
                        ensemble.insert(caseDuCarre)
                        dico[carre] = ensemble
                    } else {
                        dico[carre] = [caseDuCarre]
                    }
                }
            }
        }
        return dico
    }
    
    func nombreDeCasesVidesInterditesParCarre(pour valeur: Int) -> [Carre: Int] {
        var dico = [Carre: Int]()
        casesVidesInterditesParCarre(pour: valeur)
            .forEach { carre, cellules in
                dico[carre] = cellules.count
            }
        return dico
    }
    
    func nombreDeCasesInterditesParCarre(pour valeur: Int) -> [Carre: Int] {
        var dico = nombreDeCasesVidesInterditesParCarre(pour: valeur)
        Grille.lesCarres.forEach { carre in
            if var  compte = dico[carre] {
                compte += casesOccupees(dans: carre).count
                dico[carre] = compte
            }
        }
        return dico
    }
    
    func carresCibles(pour valeur: Int) -> [Carre] {
        let dico = nombreDeCasesInterditesParCarre(pour: valeur)
            .filter { carre, x in
                x == 8
            }
        return dico.keys.map { $0 }
    }
}
