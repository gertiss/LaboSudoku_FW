//
//  Grille.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 12/01/2023.
//

import Foundation


public struct Grille: UneGrille {
    
    /// La valeur d'une case s'obtient par contenu[indexLigne][indexColonne].  0 si case vide
    /// Voir fonction d'accès valeur(laCase:)
    private var contenu: [[Int]]
    public var commentaire: String
    
        
    public init(contenu: [[Int]], commentaire: String = "") {
        self.contenu = contenu
        self.commentaire = commentaire
    }
    
    public init(commentaire: String = "") {
        self.contenu = [[Int]]()
        self.commentaire = commentaire
        self.contenu = Self.contenuVide
    }

    public static let vide = Grille()
        
    public static let lesCases: [Case] = calculCases
    static let lesLignes: [Ligne] = calculLignes
    public static let lesColonnes: [Colonne] = calculColonnes
    public static let lesCarres: [Carre] = calculCarres
    public static let lesZones: [any UneZone] = calculZones

    public var description: String {
        "Grille(contenu: \(contenu))"
    }
    
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
        calculLignes + calculColonnes + calculCarres
    }
}

// MARK: - Etat actuel de remplissage

public extension Grille {
    
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

// MARK: - Jeu

public extension Grille {
    
    func validite(_ leCoup: Coup) -> Result<Bool, String> {
        let (ligne, colonne) = (leCoup.laCase.ligne, leCoup.laCase.colonne)
        var copie = self
        copie.contenu[ligne][colonne] = leCoup.valeur
        
        for ligne in Self.lesLignes {
            if !copie.estValide(ligne) {
                return .failure("\(ligne) contient déjà \(leCoup.valeur)")
            }
        }
        for colonne in Self.lesColonnes {
            if !copie.estValide(colonne) {
                return .failure("\(colonne) contient déjà \(leCoup.valeur)")
            }
        }
        for carre in Self.lesCarres {
            if !copie.estValide(carre) {
                return .failure("\(carre) contient déjà \(leCoup.valeur)")
            }
        }
        return .success(true)
    }
    
    func estValide<Z: UneZone>(_ zone: Z) -> Bool {
        zone.estValide(dans: self)
    }
    
    func estValide(coup: Coup) -> Bool {
        validite(coup).estSucces
    }
    
    func plus(_ unCoup: Coup) -> Result<Grille, String> {
        if let message = validite(unCoup).erreur {
            return .failure(message)
        }
        let (ligne, colonne) = (unCoup.laCase.ligne, unCoup.laCase.colonne)
        var copie = self
        copie.contenu[ligne][colonne] = unCoup.valeur
        return .success(copie)
    }
    
    func moins(_ uneCase: Case) -> Grille {
        let (ligne, colonne) = (uneCase.ligne, uneCase.colonne)
        var copie = self
        copie.contenu[ligne][colonne] = 0
        return copie
    }
    
    /// Une grille est valide si ses 27 zones sont valides.
    /// Ici il n'est pas nécessaire que la grille soit complètement remplie.
    /// C'est une validté partielle, provisoire.
    var estValide: Bool {
        Grille.lesZones.allSatisfy { estValide($0) }
    }
    
    var estSolution: Bool {
        estValide && Grille.lesCases.allSatisfy { !caseEstVide($0) }
    }
}

// MARK: - Codage

public extension Grille {
    
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

