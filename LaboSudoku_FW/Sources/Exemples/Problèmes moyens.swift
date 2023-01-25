//
//  Problèmes moyens.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 24/01/2023.
//

import Foundation

extension Grille {
    
    static let moyen1 = Grille(
        contenu: [
            [4, 0, 0,  0, 0, 8,  0, 0, 0],
            [0, 3, 0,  7, 0, 5,  1, 0, 0],
            [0, 0, 0,  0, 2, 0,  0, 0, 8],
            
            [2, 5, 0,  3, 0, 0,  8, 0, 0],
            [0, 8, 0,  4, 6, 1,  0, 5, 0],
            [0, 0, 4,  0, 0, 2,  0, 6, 7],
             
            [7, 0, 0,  0, 5, 0,  0, 0, 0],
            [0, 0, 9,  8, 0, 7,  0, 1, 0],
            [0, 0, 0,  0, 0, 0,  0, 0, 6]
        ],
        commentaire: "Sur Internet sudokuexchange.com, vidéo demo. Exige les paires")

}
