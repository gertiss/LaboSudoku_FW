//
//  Bijection.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 20/01/2023.
//

import Foundation

/// Une bijection entre cases et valeurs à l'intérieur d'une zone.
/// Intéressant lorsque c'est un singleton ou une paire
/// Contraintes vérifiées à l'init : toutes les cases sont dans la zone, toutes les valeurs sont valides et le nombre de cases est égal au nombre de valeurs.
public struct Bijection<Z: UneZone> {
    public var cases: [Case]
    public var valeurs: [Int]
    public var zone: Z
    
    public init(cases: [Case], valeurs: [Int], zone: Z) {
        assert(valeurs.allSatisfy { $0 >= 1 && $0 <= 9 })
        assert(valeurs.count == cases.count)
        let casesZone = zone.lesCases
        assert(cases.allSatisfy { casesZone.contains($0) })
        self.cases = cases
        self.valeurs = valeurs
        self.zone = zone
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
