//
//  UneGrille.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 12/01/2023.
//

import Foundation

protocol UneGrille {
    init()
    init(contenu: [[Int]])
    func valeur(_ laCase: Case) -> Int // 0 si pas de valeur
    func validite(_ leCoup: Coup) -> Result<Bool, String>
    var code: Result<String, String>  { get }
    static func avecCode(_ code: String) -> Result<Grille, String>
    
    func plus(_ unCoup: Coup) -> Result<Grille, String>
    func ligne(_ laCase: Case) -> Ligne
    func colonne(_ laCase: Case) -> Colonne
    func carre(_ laCase: Case) -> Carre
}
