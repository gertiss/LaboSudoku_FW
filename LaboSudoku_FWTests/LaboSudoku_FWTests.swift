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

    func testGrilleVide() {
        let grille = Grille()
        XCTAssert(grille.estVide)
    }
    
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
}

