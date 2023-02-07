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

        
    
    /// Une init sans paramètres crée une grilleAvecContenu vide.
    func testGrilleVide() {
        let grilleAvecContenu = GrilleAvecContenu()
        XCTAssert(grilleAvecContenu.estVide)
        XCTAssert(grilleAvecContenu.estValide)
    }
    
    /// Vérifie que les 27 zones sont valides
    func testGrilleValide() {
        XCTAssert(GrilleAvecContenu.exemple22.estValide)
    }
    
    /// On engendre le code json d'une grilleAvecContenu vide et on le relit.
    /// On vérifie que la nouvelle grilleAvecContenu obtenue est vide
    func testCodableGrilleVide() {
        let grilleAvecContenu = GrilleAvecContenu()
        switch grilleAvecContenu.codeJSON {
        case .failure(let message):
            XCTFail(message)
        case .success(let json):
            print(json)
            switch GrilleAvecContenu.avecCodeJSON(json) {
            case .failure(let message):
                XCTFail(message)
            case .success(let grilleBis):
                XCTAssert(grilleBis.estVide)
            }
        }
    }
    
    /// On engendre le code json d'une grilleAvecContenu exemple non vide et on le relit.
    /// On vérifie que la nouvelle grilleAvecContenu obtenue est égale à la grilleAvecContenu de départ
    func testCodableExemple() {
        let grilleAvecContenu = GrilleAvecContenu.exemple22
        print(grilleAvecContenu.description)
        switch grilleAvecContenu.codeJSON {
        case .failure(let message):
            XCTFail(message)
        case .success(let json):
            print(json)
            switch GrilleAvecContenu.avecCodeJSON(json) {
            case .failure(let message):
                XCTFail(message)
            case .success(let grilleBis):
                XCTAssertEqual(grilleBis, grilleAvecContenu)
            }
        }
    }
    
    /// On part d'une grilleAvecContenu vide et on cherche à jouer un coup.
    /// On vérifie d'abord que ce coup est valide.
    /// Puis on joue ce coup.
    /// Puis on vérifie que la grilleAvecContenu obtenue est bien ce qu'on attend.
    func testPlusValide() {
        let grilleAvecContenu = GrilleAvecContenu()
        let coup = Coup(Case(0,0), 1)
        guard grilleAvecContenu.validite(coup).estSucces else {
            XCTFail()
            return
        }
        let essaiCoup = grilleAvecContenu.plus(coup)
        guard essaiCoup.estSucces else {
            // Normalement impossible, puisque le coup est valide
            XCTFail()
            return
        }
        let nouvelleGrille = essaiCoup.valeur!
        print(nouvelleGrille.codeJSON.texte)
        
        XCTAssertEqual(nouvelleGrille.valeur(Case(0, 0)), 1)
    }
    
    func testCoupInvalide() {
        let grilleAvecContenu = GrilleAvecContenu.exemple22
        
        // Coup invalide dans une ligne
        let validiteLigne = grilleAvecContenu.validite(Coup(Case(1,0), 6))
        XCTAssertFalse(validiteLigne.estSucces)
        print(validiteLigne.texte)
        // message: "Ligne(1) contient déjà 6"
        
        // Coup invalide dans un carré
        let validiteCarre = grilleAvecContenu.validite(Coup(Case(0,3), 6))
        XCTAssertFalse(validiteCarre.estSucces)
        print(validiteCarre.texte)
        // message: "Carre(0, 1) contient déjà 6"
        
        
        // Coup invalide dans une colonne
       let validiteColonne = grilleAvecContenu.validite(Coup(Case(0,4), 6))
        XCTAssertFalse(validiteColonne.estSucces)
        print(validiteColonne.texte)
        // message: "Colonne(4) contient déjà 6"
    }
    
    /// On essaye de jouer un coup invalide sans tester préalablement sa validité
    func testPlusInvalide() {
        let grilleAvecContenu = GrilleAvecContenu.exemple22
        let essaiPlus = grilleAvecContenu.plus(Coup(Case(1,0), 6))
        XCTAssertFalse(essaiPlus.estSucces)
        print(essaiPlus.texte)
        // Ligne(1) contient déjà 6
    }
    
    /// Pattern : deux rayons parallèles, un rayon perpendiculaire, une case occupée
    func testExo2() {
        let grilleAvecContenu = GrilleAvecContenu.exo2
        
        XCTAssertEqual(grilleAvecContenu.coupsObligesApresEliminationDirecteParRayonnement, [Coup(Case(8, 8), 1)])
        XCTAssertEqual(grilleAvecContenu.coupsObligesParUniqueValeurPossible, [])
    }
    
    /// Pattern : une ligne avec 3 cases vides dont une obligée
    func testPattern_JD_1() {
        let grilleAvecContenu = GrilleAvecContenu.pattern_JD_1
                
        XCTAssertEqual(grilleAvecContenu.coupsObligesApresEliminationDirecteParRayonnement, [])
        XCTAssertEqual(grilleAvecContenu.coupsObligesParUniqueValeurPossible, [Coup(Case(8, 0), 1)])
    }
    
    func testExemple22() {
        let grilleAvecContenu = GrilleAvecContenu.exemple22
        // Focalisation : pour chaque valeur, chercher les cases obligées
        XCTAssertEqual(grilleAvecContenu.coupsObligesApresEliminationDirecteParRayonnement, [Coup(Case(4, 4), 7), Coup(Case(3, 8), 8), Coup(Case(3, 0), 3), Coup(Case(8, 7), 5), Coup(Case(7, 8), 3)])
        XCTAssertEqual(grilleAvecContenu.coupsObligesParUniqueValeurPossible, [Coup(Case(8, 4), 3), Coup(Case(6, 8), 4)])

        print(grilleAvecContenu.texte)
        print(grilleAvecContenu.partie.succes)
        print(grilleAvecContenu.partie.deroulement)
    }
    
    func testLeMondeFacile2() {
        let grilleAvecContenu = GrilleAvecContenu.LeMondeFacile2
        // Focalisation : pour chaque valeur, chercher les cases obligées
        XCTAssertEqual(grilleAvecContenu.coupsObligesApresEliminationDirecteParRayonnement, [Coup(Case(2, 6), 2), Coup(Case(0, 1), 6)].ensemble)
                
        XCTAssertEqual(grilleAvecContenu.coupsObligesParUniqueValeurPossible, [Coup(Case(2, 1), 3), Coup(Case(0, 6), 9)].ensemble)
        print(grilleAvecContenu.texte)
        print(grilleAvecContenu.partie.succes)
   }
    
    func testRayonsSecondaires() {
        let grilleAvecContenu = GrilleAvecContenu.patternIndirect
        // Focalisation pour chaque case de la zone, chercher les valeurs obligées
        let casesEliminees = grilleAvecContenu.casesElimineesParRayonnement(pour: 1)
        let casesOccupees = grilleAvecContenu.casesOccupees(dans: Carre(1, 2))
        
        let casesLibres = Carre(1, 2).casesLibres(casesEliminees: casesEliminees, casesOccupees: casesOccupees)
        XCTAssertEqual(casesLibres, [Case(4, 6), Case(5, 6)])
        XCTAssert(Carre(1, 2).estColonneEmettrice(index: 6, casesLibres: casesLibres))
    }
    
    
    func testTexte() {
        let grilleAvecContenu = GrilleAvecContenu.patternRayonnementIndirectDouble
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
        XCTAssertEqual(grilleAvecContenu.texte, texteAttendu)
    }
    
    func testPremierCoup() {
        
        func afficherCoup(_ grilleAvecContenu: GrilleAvecContenu) {
            print()
            print(grilleAvecContenu.texte)
            print()
            print(grilleAvecContenu.premierCoup?.explication ?? "aucun coup trouvé")
        }
        
        afficherCoup(GrilleAvecContenu.patternRayonnementIndirectDouble)
        afficherCoup(GrilleAvecContenu.patternIndirect)
        afficherCoup(GrilleAvecContenu.pattern_JD_1)
        afficherCoup(GrilleAvecContenu.exo2)
        afficherCoup(GrilleAvecContenu.LeMondeFacile2)
    }
    
    func testPartie() {
        func afficherCoup(_ grilleAvecContenu: GrilleAvecContenu) {
            print()
            print(grilleAvecContenu.premierCoup?.explication ?? "aucun coup trouvé")
        }
        var grilleAvecContenu = GrilleAvecContenu.LeMondeFacile2
        print(grilleAvecContenu.texte)
        
        var coup = grilleAvecContenu.premierCoup
        while coup != nil {
            let premierCoup = coup!
            afficherCoup(grilleAvecContenu)
            grilleAvecContenu = grilleAvecContenu.plus(premierCoup.coup).valeur!
            print("\n\(grilleAvecContenu.texte)")
            coup = grilleAvecContenu.premierCoup
        }
        
        // Succès
        if grilleAvecContenu.estSolution {
            print("\nSuccès")
        } else {
            print("\nEchec")
        }
        XCTAssert(grilleAvecContenu.estSolution)
    }
    
    func testPartieDifficile() {
        let grilleAvecContenu = GrilleAvecContenu.LeMondeDifficile
        print(grilleAvecContenu.texte)
        let partie = grilleAvecContenu.partie
        partie.coups.forEach { print($0.explication) }
        print("succès:", partie.succes) // Blocage ?

    }
    
    func testPartieFacile3() {
        let grilleAvecContenu = GrilleAvecContenu.moyen1
        print(grilleAvecContenu.texte)
        let partie = grilleAvecContenu.partie
        partie.coups.forEach { print($0.explication) }
        print("succès:", partie.succes) // Blocage ?

    }
    
    func testRadar() {
        let cellules = GrilleAvecContenu.radar(Case(4, 5))
        XCTAssertEqual(cellules.count, 20)
        XCTAssertEqual(cellules, [Case(4, 4), Case(6, 5), Case(4, 6), Case(3, 5), Case(5, 5), Case(0, 5), Case(8, 5), Case(4, 3), Case(2, 5), Case(3, 4), Case(7, 5), Case(4, 7), Case(5, 4), Case(3, 3), Case(4, 1), Case(4, 8), Case(1, 5), Case(5, 3), Case(4, 2), Case(4, 0)])
    }
    
    func testMoyen2() {
        // Le coup Bf = 5 n'est pas trouvé ?
        // Pourtant la stratégie .rechercheDeValeursPourCase devrait le trouver.
        let grilleAvecContenu = GrilleAvecContenu.moyen2
        
        let recherche = Recherche(strategie: .rechercheDeValeursPourCase)
        let coup = recherche.premierCoup(pour: grilleAvecContenu)
        XCTAssertNotNil(coup)
        XCTAssertEqual(coup?.coup, Coup(Case(1, 5), 5))
        print(coup?.explication ?? "nil")
        // On doit trouver Bf 5
        
    }


}

