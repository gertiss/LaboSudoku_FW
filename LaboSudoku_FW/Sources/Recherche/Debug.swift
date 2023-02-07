//
//  Debug.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 28/01/2023.
//

import Foundation

// MARK: - Debug

public extension GrilleAvecContenu {
        
    /// On affiche le premier coup éventuel
    func printDansConsoleXcode() {
        print("\nDebug Framework {")
        guard estValide else {
            print("Erreur: grilleAvecContenu non valide")
            return
        }
        if estSolution {
            print("Terminé avec succès")
            return
        }
        
        print("Singletons:")
        print(coups.map { $0.description }.joined(separator: "\n"))
        print()
        
        print("Paires 2 valeurs 2 cases :")
        let textePaires =  pairesDeuxValeursDeuxCases
            .map { "\($0)" }
            .joined(separator: "\n")
        print(textePaires)
        print()
        
        let reste = GrilleAvecContenu.lesCases.filter {
            caseEstVide($0)
        }
        print("Il reste \(reste.count) cases")
        print("} Debug Framework")
        return
    }
    
}
