//
//  Grille Exemples.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 12/01/2023.
//

import Foundation


public extension Grille {
    /// Grille facile du Monde du vendredi 6 janvier 2023
    /// 22 cases remplies au départ
    static let exemple22 = Grille(contenu: [
        [0, 0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 6, 0, 0, 0, 1],
        [0, 0, 0, 0, 0, 7, 0, 8, 0],
        
        [0, 0, 7, 0, 0, 0, 0, 0, 0],
        [0, 0, 1, 0, 0, 0, 0, 3, 6],
        [0, 0, 0, 0, 9, 3, 5, 0, 2],
        
        [0, 3, 0, 0, 5, 6, 0, 0, 0],
        [0, 5, 0, 0, 2, 0, 9, 0, 0],
        [0, 0, 4, 0, 0, 1, 8, 0, 7]
    ])
    
    static let exo2 = Grille(contenu:[
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,1,0],
        [0,1,0,0,0,0,0,0,0],
        [0,0,0,0,1,0,0,0,0],
        [0,0,0,0,0,0,2,0,0]])
}
