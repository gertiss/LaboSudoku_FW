//
//  Bijection.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 20/01/2023.
//

import Foundation

// Travail en cours. Non utilisé

/// Une bijection entre cases et valeurs.
/// Intéressant lorsque c'est un singleton ou une paire.
/// Contraintes à l'init : toutes les valeurs sont valides et le nombre de cases est égal au nombre de valeurs.
public struct Bijection {
    public var cases: Set<Case>
    public var valeurs: Set<Int>
    
    public init(cases: Set<Case>, valeurs: Set<Int>) {
        assert(valeurs.allSatisfy { $0 >= 1 && $0 <= 9 })
        assert(valeurs.count == cases.count)
        self.cases = cases
        self.valeurs = valeurs
    }
    
}

public extension Bijection {
    
    /// Quand la bijection est un singleton, c'est qu'on a trouvé la valeur de la case et qu'on peut jouer le coup.
    /// On pourra alors mettre à jour toutes les bijections qui contiennent la case et la valeur en les réduisant aux cases et valeurs qui restent. La combinatoire diminue, l'information augmente.
    var estSingleton: Bool {
        cases.count == 1
    }
    
    var estPaire: Bool {
        cases.count == 2
    }
}
