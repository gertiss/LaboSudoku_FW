//
//  ContrainteValeurPaireDansCarre.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 26/01/2023.
//

import Foundation

/// Représente une contrainte signifiant : le chiffre donné ne peut aller que dans les deux cellules données dans le carré donné
public struct ContrainteValeurPaireDansCarre : Hashable, Codable {
    
    public var valeur: Int
    public var paireCases: Set<Case> // à deux éléments
    public var carre: Carre
    
    public init(valeur: Int, paireCases: Set<Case>, carre: Carre) {
        self.valeur = valeur
        self.paireCases = paireCases
        self.carre = carre
        assert(paireCases.count == 2)
    }
    
}

public extension GrilleAvecContenu {
    
    func casesCandidates(valeur: Int, carre: Carre) -> Set<Case> {
        // Pour chaque émetteur, parcourir les rayons et éliminer les cases impossibles.
        // Garder les cases restantes si elles forment une paire.
        fatalError()
    }
    
    func casesCandidates(paireValeurs: Set<Int>, carre: Carre) -> Set<Int> {
        // Pour chaque paire de valeurs, appliquer casesCandidates(valeur, carre)
        fatalError()
    }
    
    mutating func actualiserContraintesValeurPaire()  {
        // pour chaque contrainte, l'enlever si elle a été résolue
        fatalError()
    }
    
    
}
