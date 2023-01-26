//
//  DicoCaseCouples.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 26/01/2023.
//

import Foundation


/// Représente une contrainte signifiant : la case donnée ne peut recevoir aucun autre chiffre que les deux de la paire.
public struct ContrainteCasePaire : Hashable, Codable {
    
    public var cellule: Case
    public var paireValeurs: Set<Int> // à deux éléments
    
    public init(cellule: Case, paireValeurs: Set<Int>) {
        self.cellule = cellule
        self.paireValeurs = paireValeurs
        assert(paireValeurs.count == 2)
    }
}

public extension Grille {
    func valeursCandidates(cellule: Case) -> Set<Int> {
        // pour chaque valeur, parcourir les "radars" de la cellule et éliminer les valeurs impossibles
        // garder les valeurs possibles si elles forment une paire.
        fatalError()
    }
    
    func valeursCandidates(paireCellules: Set<Case>) -> Set<Int> {
        // pour chaque paire de cellules, appliquer valeursCandidates(cellule)
        fatalError()
    }
}
