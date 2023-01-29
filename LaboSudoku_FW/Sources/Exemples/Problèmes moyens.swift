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

    static let moyen2 = Grille(
        contenu: [
            [0,0,0,0,0,0,8,6,2],
            [0,0,0,0,0,0,7,9,1],
            [0,0,0,0,0,0,5,3,4],
            [0,0,0,0,0,0,1,8,6],
            [6,7,3,9,1,8,2,4,5],
            [1,8,5,6,4,2,9,7,3],
            [3,1,9,7,5,6,4,2,8],
            [2,5,6,8,9,4,3,1,7],
            [8,4,7,1,2,3,6,5,9]
            ],
        commentaire: "Blocage : un coup repéré 5 en Bf, mais non trouvé"
        )
}
