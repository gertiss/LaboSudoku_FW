//
//  RayonnementIndirect.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 18/01/2023.
//

import Foundation

/*
 Pour une valeur donnée, on élimine d'abord toutes les cases par rayonnement direct.
 Puis on cherche les "émetteurs secondaires" : ensemble de deux cases non éliminées alignées dans un même carré. "alignées" signifie : appartenant à la même ligne ou à la même colonne.
 Cette ligne ou cette colonne joue alors le rôle d'émetteur secondaire car elle envoie des rayons à l'extérieur du carré.
 Avec ces rayons, on continue à éliminer des cases pour la valeur considérée, ce qui peut récursivement faire découvrir de nouvelles cases obligées et/ou de nouveaux émetteurs secondaires.
 
 Plus le niveau de récursivité est grand, plus la charge mentale nécessaire est grande.
 
 Il y a aussi une autre forme d'émetteur secondaire : les émetteurs secondaires doubles, qui exigent d'être présents dans deux carrés, et qui éliminent finalement deux lignes.
 
 Pour commencer, on va se restreindre aux émetteurs simples non récursifs permettant de découvrir un coup obligé. Cela définit un certain niveau de jeu, encore assez facile.
 
 */

public extension GrilleAvecContenu {
    
    func casesElimineesParRayonnementIndirect(pour valeur: Int) -> Set<Case> {
        let casesEliminees = casesElimineesParRayonnement(pour: valeur)
        let ensemble = casesEliminees
        for carre in GrilleAvecContenu.lesCarres {
            let casesOccupees = casesOccupees(dans: carre)
            let casesLibres = carre.casesLibres(casesEliminees: casesEliminees, casesOccupees: casesOccupees)
            for indexLigne in carre.rangeLignes {
                if carre.estLigneEmettrice(index: indexLigne, casesLibres: casesLibres) {
                    
                }
            }
            for indexColonne in carre.rangeColonnes {
                if carre.estColonneEmettrice(index: indexColonne, casesLibres: casesLibres) {
                }
            }
        }
        
        
        return ensemble
    }
}


public extension Carre {
 
    func casesLibres(casesEliminees: Set<Case>, casesOccupees: Set<Case>) -> Set<Case> {
        lesCases.ensemble
            .subtracting(casesEliminees)
            .subtracting(casesOccupees)
    }
    
    // MARK: - Lignes émettrices
    
    func casesDansLigne(index: Int) -> Set<Case> {
        [Case(index, bandeV * 3), Case(index, bandeV * 3 + 1), Case(index, bandeV * 3 + 2)]
    }

    func estLigneEmettrice(index: Int, casesLibres: Set<Case>) -> Bool {
        casesDansLigne(index: index)
            .filter { casesLibres.contains($0) }
            .count >= 2
    }
 
    // MARK: - Colonnes émettrices
    
    func casesDansColonne(index: Int) -> Set<Case> {
        [Case(bandeH * 3, index), Case(bandeH * 3 + 1, index), Case(bandeH * 3 + 2, index)]
    }

    func estColonneEmettrice(index: Int, casesLibres: Set<Case>) -> Bool {
        casesDansColonne(index: index)
            .filter { casesLibres.contains($0) }
            .count >= 2
    }

}
