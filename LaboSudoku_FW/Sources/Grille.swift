//
//  Grille.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 12/01/2023.
//

import Foundation


/// Pour des raisons d'efficacité, on stocke la topologie :
/// cases, lignes, colonnes, carrés
struct Grille: Codable {
    
    /// La valeur d'une case s'obtient par contenu[indexLigne][indexColonne].  0 si case vide
    /// Voir fonction d'accès valeur(laCase:)
    private var contenu: [[Int]]
    
        
    init(contenu: [[Int]]) {
        self.contenu = contenu
    }
    
    init() {
        self.contenu = [[Int]]()
        self.contenu = contenuVide
    }

    static let vide = Grille()
        
    /// Les 81 cases de la grille
    var calculCases: [Case] {
        var liste = [Case]()
        for ligne in 0...8 {
            for colonne in 0...8 {
                liste.append(Case(ligne, colonne))
            }
        }
        return liste
    }
    
    var calculCarres: [Carre] {
        var liste = [Carre]()
        for bandeH in 0...2 {
            for bandeV in 0...2 {
                liste.append(Carre(bandeH, bandeV))
            }
        }
        return liste
    }
    
    var calculLignes: [Ligne] {
        (0...8).map { Ligne($0) }
    }
    
    var calculColonnes: [Colonne] {
        (0...8).map { Colonne($0) }
    }
    
    var contenuVide: [[Int]] {
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
    }
    
    
}

// MARK: - Topologie

extension Grille {
    
    func cases(ligne: Ligne) -> [Case] {
        ligne.lesCases
    }
    
    func cases(colonne: Colonne) -> [Case] {
        colonne.lesCases
    }
    
    func cases(carre: Carre) -> [Case] {
        carre.lesCases
    }
    
}

// MARK: - Etat actuel de remplissage

extension Grille {
    
    /// Valeur de 0 à 9, 0 signifiant valeur inconnue.
    func valeur(_ laCase: Case) -> Int {
        contenu[laCase.ligne][laCase.colonne]
    }
    
    func caseEstVide(_ laCase: Case) -> Bool {
        valeur(laCase) == 0
    }
    
    var estVide: Bool {
        for ligne in 0...8 {
            for colonne in 0...8 {
                if contenu[ligne][colonne] != 0 {
                    return false
                }
            }
        }
        return true
    }
}

// MARK : - Codage

extension Grille {
    
    static func avecCode(_ code: String) -> Result<Grille, String> {
        let decoder = JSONDecoder()
        guard let data = code.data(using: .utf8) else {
            return .failure("Decodage: Impossible de créer data. Le code est censé être du json valide en utf8")
        }
        do {
            let instance = try decoder.decode(Grille.self, from: data)
            return .success(instance)
        } catch {
            return .failure("Erreur de décodage : \(error)")
        }
    }
    
    var code: Result<String, String> {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            guard let texte = String(data: data, encoding: .utf8) else {
                return .failure("Codage: Impossible de créer data")
            }
            return .success(texte)
       } catch {
           return .failure("Erreur de décodage : \(error)")
        }
    }
}

