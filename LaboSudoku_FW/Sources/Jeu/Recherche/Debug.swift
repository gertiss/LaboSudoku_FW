//
//  Debug.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 28/01/2023.
//

import Foundation

// MARK: - Debug

public extension Grille {
        
    /// On affiche le premier coup éventuel
    func printDansConsoleXcode() {
        print("\n Debug Framework")
        if let premierCoup {
            print("Coup:")
            print(premierCoup.explication)
        }
        print("aucun coup trouvé")
        guard estValide else {
            print("Erreur: grille non valide")
            return
        }
        if estSolution {
            print("Terminé avec succès")
            return
        }
        if  !pairesDeCases.isEmpty {
            print("Paires :")
            let explication =  pairesDeCases.parOrdreDeValeurs.map { $0.explication }.joined(separator: "\n")
            print(explication)
        }
        let reste = Grille.lesCases.filter {
            caseEstVide($0)
        }
        print("Blocage : il reste \(reste.count) cases")
        return
    }
    
}
