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
