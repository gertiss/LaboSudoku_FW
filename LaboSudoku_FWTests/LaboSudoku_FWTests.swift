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

    func testLesZones() {
        XCTAssertEqual(Grille.lesZones.count, 27)
        
        // On ne peut pas tester directement l'égalité :
        // Type 'any UneZone' cannot conform to 'Equatable'.
        // On se contente de l'égalité des descriptions.
        XCTAssertEqual(
            "\(Grille.lesZones)",
            "[Ligne(0), Ligne(1), Ligne(2), Ligne(3), Ligne(4), Ligne(5), Ligne(6), Ligne(7), Ligne(8), Colonne(0), Colonne(1), Colonne(2), Colonne(3), Colonne(4), Colonne(5), Colonne(6), Colonne(7), Colonne(8), Carre(0, 0), Carre(0, 1), Carre(0, 2), Carre(1, 0), Carre(1, 1), Carre(1, 2), Carre(2, 0), Carre(2, 1), Carre(2, 2)]"
        )
        
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
    /// Valeur cherchée : 1
    /// Un seul coup certain possible : Coup(Case(8, 8), 1)
    func testExo2() {
        let grille = Grille.exo2
        
        print("interdites pour 1:", grille.nombreDeCasesImpossiblesParCarre(pour: 1))
        
    }
    
}

