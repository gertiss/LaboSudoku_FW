//
//  LaboSudoku_FWTests.swift
//  LaboSudoku_FWTests
//
//  Created by Gérard Tisseau on 12/01/2023.
//

import XCTest
@testable import LaboSudoku_FW

final class LaboSudoku_FWTests: XCTestCase {

    override func setUpWithError() throws {
        print()
    }

    override func tearDownWithError() throws {
        print()
    }

        
    
    /// Une init sans paramètres crée une grille vide.
    func testGrilleVide() {
        let grille = Grille()
        XCTAssert(grille.estVide)
        XCTAssert(grille.estValide)
    }
    
    /// Vérifie que les 27 zones sont valides
    func testGrilleValide() {
        XCTAssert(Grille.exemple22.estValide)
    }
    
    /// On engendre le code json d'une grille vide et on le relit.
    /// On vérifie que la nouvelle grille obtenue est vide
    func testCodableGrilleVide() {
        let grille = Grille()
        switch grille.code {
        case .failure(let message):
            XCTFail(message)
        case .success(let json):
            print(json)
            switch Grille.avecCode(json) {
            case .failure(let message):
                XCTFail(message)
            case .success(let grilleBis):
                XCTAssert(grilleBis.estVide)
            }
        }
    }
    
    /// On engendre le code json d'une grille exemple non vide et on le relit.
    /// On vérifie que la nouvelle grille obtenue est égale à la grille de départ
    func testCodableExemple() {
        let grille = Grille.exemple22
        print(grille.description)
        switch grille.code {
        case .failure(let message):
            XCTFail(message)
        case .success(let json):
            print(json)
            switch Grille.avecCode(json) {
            case .failure(let message):
                XCTFail(message)
            case .success(let grilleBis):
                XCTAssertEqual(grilleBis, grille)
            }
        }
    }
    
    /// On part d'une grille vide et on cherche à jouer un coup.
    /// On vérifie d'abord que ce coup est valide.
    /// Puis on joue ce coup.
    /// Puis on vérifie que la grille obtenue est bien ce qu'on attend.
    func testPlusValide() {
        let grille = Grille()
        let coup = Coup(Case(0,0), 1)
        guard grille.validite(coup).estSucces else {
            XCTFail()
            return
        }
        let essaiCoup = grille.plus(coup)
        guard essaiCoup.estSucces else {
            // Normalement impossible, puisque le coup est valide
            XCTFail()
            return
        }
        let nouvelleGrille = essaiCoup.valeur!
        print(nouvelleGrille.code.texte)
        
        XCTAssertEqual(nouvelleGrille.valeur(Case(0, 0)), 1)
    }
    
    func testCoupInvalide() {
        let grille = Grille.exemple22
        
        // Coup invalide dans une ligne
        let validiteLigne = grille.validite(Coup(Case(1,0), 6))
        XCTAssertFalse(validiteLigne.estSucces)
        print(validiteLigne.texte)
        // message: "Ligne(1) contient déjà 6"
        
        // Coup invalide dans un carré
        let validiteCarre = grille.validite(Coup(Case(0,3), 6))
        XCTAssertFalse(validiteCarre.estSucces)
        print(validiteCarre.texte)
        // message: "Carre(0, 1) contient déjà 6"
        
        
        // Coup invalide dans une colonne
       let validiteColonne = grille.validite(Coup(Case(0,4), 6))
        XCTAssertFalse(validiteColonne.estSucces)
        print(validiteColonne.texte)
        // message: "Colonne(4) contient déjà 6"
    }
    
    /// On essaye de jouer un coup invalide sans tester préalablement sa validité
    func testPlusInvalide() {
        let grille = Grille.exemple22
        let essaiPlus = grille.plus(Coup(Case(1,0), 6))
        XCTAssertFalse(essaiPlus.estSucces)
        print(essaiPlus.texte)
        // Ligne(1) contient déjà 6
    }
    
    /// Pattern : deux rayons parallèles, un rayon perpendiculaire, une case occupée
    func testExo2() {
        let grille = Grille.exo2
        
        XCTAssertEqual(grille.coupsObligesApresEliminationDirecteParRayonnement, [Coup(Case(8, 8), 1)])
        XCTAssertEqual(grille.coupsObligesParUniqueValeurPossible, [])
    }
    
    /// Pattern : une ligne avec 3 cases vides dont une obligée
    func testPattern_JD_1() {
        let grille = Grille.pattern_JD_1
                
        XCTAssertEqual(grille.coupsObligesApresEliminationDirecteParRayonnement, [])
        XCTAssertEqual(grille.coupsObligesParUniqueValeurPossible, [Coup(Case(8, 0), 1)])
    }
    
    func testExemple22() {
        let grille = Grille.exemple22
        // Focalisation : pour chaque valeur, chercher les cases obligées
        XCTAssertEqual(grille.coupsObligesApresEliminationDirecteParRayonnement, [Coup(Case(4, 4), 7), Coup(Case(3, 8), 8), Coup(Case(3, 0), 3), Coup(Case(8, 7), 5), Coup(Case(7, 8), 3)])
        XCTAssertEqual(grille.coupsObligesParUniqueValeurPossible, [Coup(Case(8, 4), 3), Coup(Case(6, 8), 4)])

        print(grille.texte)
        print(grille.partie.succes)
    }
    
    func testLeMondeFacile2() {
        let grille = Grille.LeMondeFacile2
        // Focalisation : pour chaque valeur, chercher les cases obligées
        XCTAssertEqual(grille.coupsObligesApresEliminationDirecteParRayonnement, [Coup(Case(2, 6), 2), Coup(Case(0, 1), 6)].ensemble)
                
        XCTAssertEqual(grille.coupsObligesParUniqueValeurPossible, [Coup(Case(2, 1), 3), Coup(Case(0, 6), 9)].ensemble)
        print(grille.texte)
        print(grille.partie.succes)
   }
    
    func testRayonsSecondaires() {
        let grille = Grille.patternIndirect
        // Focalisation pour chaque case de la zone, chercher les valeurs obligées
        let casesEliminees = grille.casesElimineesParRayonnement(pour: 1)
        let casesOccupees = grille.casesOccupees(dans: Carre(1, 2))
        
        let casesLibres = Carre(1, 2).casesLibres(casesEliminees: casesEliminees, casesOccupees: casesOccupees)
        XCTAssertEqual(casesLibres, [Case(4, 6), Case(5, 6)])
        XCTAssert(Carre(1, 2).estColonneEmettrice(index: 6, casesLibres: casesLibres))
    }
    
    
    func testTexte() {
        let grille = Grille.patternRayonnementIndirectDouble
        let texteAttendu = """
  a b c d e f g h i
A · · · · · · · · ·
B · · · · · · · · ·
C · · · · · 1 · 8 ·
D · · · 5 · · · · ·
E 5 · · · · · · · ·
F · · · · · · · · 5
G · 5 · · · · · · ·
H · · · · · · 5 · ·
I · · · · 5 · · · ·
"""
        XCTAssertEqual(grille.texte, texteAttendu)
    }
    
    func testPremierCoup() {
        
        func afficherCoup(_ grille: Grille) {
            print()
            print(grille.texte)
            print()
            print(grille.premierCoup?.explication ?? "aucun coup trouvé")
        }
        
        afficherCoup(Grille.patternRayonnementIndirectDouble)
        afficherCoup(Grille.patternIndirect)
        afficherCoup(Grille.pattern_JD_1)
        afficherCoup(Grille.exo2)
        afficherCoup(Grille.LeMondeFacile2)
    }
    
    func testPartie() {
        func afficherCoup(_ grille: Grille) {
            print()
            print(grille.premierCoup?.explication ?? "aucun coup trouvé")
        }
        var grille = Grille.LeMondeFacile2
        print(grille.texte)
        
        var coup = grille.premierCoup
        while coup != nil {
            let premierCoup = coup!
            afficherCoup(grille)
            grille = grille.plus(premierCoup.coup).valeur!
            print("\n\(grille.texte)")
            coup = grille.premierCoup
        }
        
        if grille.estSolution {
            print("\nSuccès")
        } else {
            print("\nEchec")
        }
    }
    
    func testPartieDifficile() {
        let grille = Grille.LeMondeDifficile
        print(grille.texte)
        let partie = grille.partie
        partie.coups.forEach { print($0.explication) }
        print("succès:", partie.succes)

    }

}

