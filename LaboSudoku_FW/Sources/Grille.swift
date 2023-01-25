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
    public static let lesZonesPourEliminationCases: [any UneZone] = calculZonesPourEliminationCases
    public static let lesZonesPourEliminationValeurs: [any UneZone] = calculZonesPourEliminationValeurs
    
    public var description: String {
        "Grille(contenu: \(contenu))"
    }
    
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
    
}

// MARK: - Etat actuel de remplissage

public extension Grille {
    
    /// Valeur de 0 à 9, 0 signifiant valeur inconnue.
    func valeur(_ laCase: Case) -> Int {
        contenu[laCase.indexLigne][laCase.indexColonne]
    }
    
    func caseEstVide(_ cellule: Case) -> Bool {
        valeur(cellule) == 0
    }
 
    func caseEstOccupee(_ laCase: Case) -> Bool {
        !caseEstVide(laCase)
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
    
    func casesRemplies(avec chiffre: Int) -> Set<Case> {
        Grille.lesCases.filter { valeur($0) == chiffre }.ensemble
    }
    
    func casesOccupees(dans carre: Carre) -> Set<Case> {
        carre.lesCases.filter { !caseEstVide($0) }.ensemble
    }
}

// MARK: - Jeu

public extension Grille {
    
    func validite(_ leCoup: Coup) -> Result<Bool, String> {
        let (ligne, colonne) = (leCoup.laCase.indexLigne, leCoup.laCase.indexColonne)
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
        let (ligne, colonne) = (unCoup.laCase.indexLigne, unCoup.laCase.indexColonne)
        var copie = self
        copie.contenu[ligne][colonne] = unCoup.valeur
        return .success(copie)
    }
    
    func moins(_ uneCase: Case) -> Grille {
        let (ligne, colonne) = (uneCase.indexLigne, uneCase.indexColonne)
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
    
    var premierCoup: CoupAvecExplication? {
        let coupCase = Recherche(strategie: .eliminationCases)
            .premierCoup(pour: self)
        if let coupCase {
            return coupCase
        }
        
        let coupValeur = Recherche(strategie: .eliminationValeurs)
            .premierCoup(pour: self)
        if let coupValeur {
            return coupValeur
        }
        return nil
    }
    
    /// Retourne tous les coups trouvés jusqu'à succès ou blocage
    var partie: Partie {
        var listeCoups = [CoupAvecExplication]()
        var grille = self
        var coup = premierCoup
        while coup != nil {
            let premierCoup = coup!
            assert(!listeCoups.contains(premierCoup))
            listeCoups.append(premierCoup)
            grille = grille.plus(premierCoup.coup).valeur!
            coup = grille.premierCoup
        }
        return Partie(grilleInitiale: self, coups: listeCoups, succes: grille.estSolution)
    }
    
}

// MARK: - Codage JSON

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

// MARK: - Représentation en texte

public extension Grille {
    
    /// La représentation d'une grille sous forme de "texte graphique"
    var texte: String {
        Grille.enTeteColonnes + "\n" +
        (0...8)
            .map { Ligne($0).texte(dans: self)}
            .joined(separator: "\n")
    }

}

// MARK: - Debug

public extension Grille {
    
    func printDansConsoleXcode() {
        // Le déroulement de la partie résolue par le framework, jusqu'à succès ou blocage
        print(partie.deroulement)
    }

}
