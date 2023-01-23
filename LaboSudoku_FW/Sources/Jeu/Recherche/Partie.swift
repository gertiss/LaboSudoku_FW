//
//  Partie.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 23/01/2023.
//

import Foundation


/// Un compte rendu de partie à partir d'une grille initiale
public struct Partie {
    public let grilleInitiale: Grille
    public let coups: [CoupAvecExplication]
    public let succes: Bool
    
    init(grilleInitiale: Grille, coups: [CoupAvecExplication], succes: Bool) {
        self.grilleInitiale = grilleInitiale
        self.coups = coups
        self.succes = succes
    }
}