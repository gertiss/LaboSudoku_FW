//
//  Grille static.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 26/01/2023.
//

import Foundation

// MARK: - Static
extension Grille {
    
    public static let vide = Grille()
        
    public static let lesCases: [Case] = calculCases
    static let lesLignes: [Ligne] = calculLignes
    public static let lesColonnes: [Colonne] = calculColonnes
    public static let lesCarres: [Carre] = calculCarres
    public static let lesZones: [any UneZone] = calculZones
    public static let lesZonesPourEliminationCases: [any UneZone] = calculZonesPourEliminationCases
    public static let lesZonesPourEliminationValeurs: [any UneZone] = calculZonesPourEliminationValeurs
    
    
    public static let nomsLignes = "ABCDEFGHI".map { String($0) }
    public static let nomsColonnes = "abcdefghi".map { String($0) }
    public static let enTeteColonnes = "  " + nomsColonnes.joined(separator: " ")

    public static let contenuVide =
        [
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0]
        ]
    
    private static var calculCases: [Case] {
        var liste = [Case]()
        for ligne in 0...8 {
            for colonne in 0...8 {
                liste.append(Case(ligne, colonne))
            }
        }
        return liste
    }

    private static var calculCarres: [Carre] {
        var liste = [Carre]()
        for bandeH in 0...2 {
            for bandeV in 0...2 {
                liste.append(Carre(bandeH, bandeV))
            }
        }
        return liste
    }
    
    private static var calculLignes: [Ligne] {
        (0...8).map { Ligne($0) }
    }
    
    private static var calculColonnes: [Colonne] {
        (0...8).map { Colonne($0) }
    }
    
    /// Utilisation d'un type "existentiel" `any UneZone`
    /// Ce genre de type a des restrictions :
    /// Type 'any UneZone' cannot conform to 'Equatable'
    /// Et cela même si UneZone est Equatable
    private static var calculZones: [any UneZone] {
        calculCarres + calculLignes + calculColonnes
    }
    
    /// La liste des zones dans un ordre favorable à l'élimination de valeurs
    private static var calculZonesPourEliminationValeurs: [any UneZone] {
        calculLignes + calculColonnes + calculCarres
    }
    
    /// La liste des zones dans un ordre favorable à l'élimination de cases
    private static var calculZonesPourEliminationCases : [any UneZone] {
        calculCarres + calculLignes + calculColonnes
    }
    
    public static func lesZones(type: TypeZone) -> [any UneZone] {
        switch type {
        case .carre:
            return lesCarres
        case .ligne:
            return lesLignes
        case .colonne:
            return lesColonnes
        }
    }
    
    public static func radar(_ cellule: Case) -> Set<Case> {
        var ensemble = Set<Case>()
        let indexLigne = cellule.indexLigne
        let indexColonne = cellule.indexColonne
        ensemble = ensemble.union(Ligne(indexLigne).lesCases)
        ensemble = ensemble.union(Colonne(indexColonne).lesCases)
        ensemble = ensemble.union(Carre(indexLigne / 3, indexColonne / 3).lesCases)
        ensemble.remove(cellule)
        return ensemble
    }
    
}