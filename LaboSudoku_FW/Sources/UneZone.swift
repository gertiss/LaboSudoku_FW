//
//  Zone.swift
//  EtudeSudokuGT
//
//  Created by Gérard Tisseau on 10/01/2023.
//

import Foundation

/// UneZone est une Ligne ou une Colonne ou un Carre
public protocol UneZone {
    var lesCases: [Case] { get }
    
    func valeursValides(dans grille: Grille) -> Bool
    func valeursDistinctes(dans grille: Grille) -> Bool
    func estValide(dans grille: Grille) -> Bool
}

public extension UneZone {
    
    func valeursValides(dans grille: Grille) -> Bool {
        lesCases.allSatisfy { laCase in
            let valeur = grille.valeur(laCase)
            return valeur >= 0 && valeur <= 9
        }
    }
    
    func valeursDistinctes(dans grille: Grille) -> Bool {
        let liste = lesCases.map { grille.valeur($0) }
            .filter { $0 != 0 }
        let ensemble = Set(liste)
        return liste.count == ensemble.count
    }
    
    /// Les valeurs sont dans 0...9 et les valeurs non nulles ne figurent qu'une fois
    func estValide(dans grille: Grille) -> Bool {
        valeursValides(dans: grille) && valeursDistinctes(dans: grille)
    }
    
    
}
