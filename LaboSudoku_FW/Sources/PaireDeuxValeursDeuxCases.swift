//
//  PaireDeuxValeursDeuxCases.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 06/02/2023.
//

import Foundation

public struct PaireDeuxValeursDeuxCases: Hashable, Codable {
    public var paireDeCases: Set<Case>
    public var paireDeValeurs: Set<Int>
    
    public init(paireDeCases: Set<Case>, paireDeValeurs: Set<Int>) {
        assert(paireDeCases.count == 2)
        assert(paireDeValeurs.count == 2)
        self.paireDeCases = paireDeCases
        self.paireDeValeurs = paireDeValeurs
    }
}
