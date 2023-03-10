//
//  Zone.swift
//  EtudeSudokuGT
//
//  Created by Gérard Tisseau on 10/01/2023.
//

import Foundation

public enum TypeZone: Hashable, Codable {
    case carre
    case ligne
    case colonne
}

/// UneZone est une Ligne ou une Colonne ou un Carre
/// Si on veut une liste de UneZone, il faut écrire `[any UneZone]`
/// Mais `any UneZone` ne peut pas être Equatable ni Hashable
/// bien que UneZone le soit
public protocol UneZone: Testable {
    var lesCases: [Case] { get }
    var type: TypeZone { get }
    
    var nom: String { get }
    func valeursValides(dans grilleAvecContenu: GrilleAvecContenu) -> Bool
    func valeursDistinctes(dans grilleAvecContenu: GrilleAvecContenu) -> Bool
    func estValide(dans grilleAvecContenu: GrilleAvecContenu) -> Bool
}

public extension UneZone {
    
    func valeursValides(dans grilleAvecContenu: GrilleAvecContenu) -> Bool {
        lesCases.allSatisfy { cellule in
            let valeur = grilleAvecContenu.valeur(cellule)
            return valeur >= 0 && valeur <= 9
        }
    }
    
    func valeursDistinctes(dans grilleAvecContenu: GrilleAvecContenu) -> Bool {
        let liste = lesCases.map { grilleAvecContenu.valeur($0) }
            .filter { $0 != 0 }
        let ensemble = Set(liste)
        return liste.count == ensemble.count
    }
    
    /// Les valeurs sont dans 0...9 et les valeurs non nulles ne figurent qu'une fois
    func estValide(dans grilleAvecContenu: GrilleAvecContenu) -> Bool {
        valeursValides(dans: grilleAvecContenu) && valeursDistinctes(dans: grilleAvecContenu)
    }
    
    
}
