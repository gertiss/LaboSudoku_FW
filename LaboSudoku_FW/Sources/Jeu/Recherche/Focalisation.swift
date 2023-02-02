//
//  Focalisation.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 23/01/2023.
//

import Foundation

public enum Focalisation: Hashable, Codable {
    case valeurZone(FocalisationValeurZone)
    case cellule(FocalisationCellule)
}

struct FocalisationValeur {
    var valeur: Int
    
    func dansZone(_ zone: some UneZone) -> FocalisationValeurZone {
        FocalisationValeurZone.avec(valeur: valeur, zone: zone)
    }
}

extension FocalisationValeurZone {
    var avecOubliDeZone: FocalisationValeur {
        FocalisationValeur(valeur: valeur)
    }
}
