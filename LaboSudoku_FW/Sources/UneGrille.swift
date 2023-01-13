//
//  UneGrille.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 12/01/2023.
//

import Foundation

public protocol UneGrille: UtilisableCommeAtome  {
    init()
    init(contenu: [[Int]])
    
    
    func valeur(_ laCase: Case) -> Int // 0 si pas de valeur
    func validite(_ leCoup: Coup) -> Result<Bool, String>
    func plus(_ unCoup: Coup) -> Result<Grille, String>

    static func ligne(_ laCase: Case) -> Ligne
    static func colonne(_ laCase: Case) -> Colonne
    static func carre(_ laCase: Case) -> Carre
    
    var code: Result<String, String>  { get }
    static func avecCode(_ code: String) -> Result<Grille, String>
}

// MARK: - Topologie

public extension UneGrille {
    
    static func cases(ligne: Ligne) -> [Case] {
        ligne.lesCases
    }
    
    static func cases(colonne: Colonne) -> [Case] {
        colonne.lesCases
    }
    
    static func cases(carre: Carre) -> [Case] {
        carre.lesCases
    }
    
    static func ligne(_ laCase: Case) -> Ligne {
        Ligne(laCase.ligne)
    }
    
    static func colonne(_ laCase: Case) -> Colonne {
        Colonne(laCase.colonne)
    }
    
    static func carre(_ laCase: Case) -> Carre {
        Carre(laCase.ligne / 3, laCase.colonne / 3)
    }

}
