//
//  UneGrille.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 12/01/2023.
//

import Foundation

public protocol UneGrilleAvecContenu: Testable  {
    init(commentaire: String)
    init(contenu: [[Int]], commentaire: String)
    
    
    func valeur(_ cellule: Case) -> Int // 0 si pas de valeur
    func validite(_ leCoup: Coup) -> Result<Bool, String>
    func plus(_ unCoup: Coup) -> Result<GrilleAvecContenu, String>
    func moins(_ uneCase: Case) -> GrilleAvecContenu
    
    static func ligne(_ cellule: Case) -> Ligne
    static func colonne(_ cellule: Case) -> Colonne
    static func carre(_ cellule: Case) -> Carre
    
    var codeJSON: Result<String, String>  { get }
    static func avecCodeJSON(_ code: String) -> Result<GrilleAvecContenu, String>
}

// MARK: - Topologie

public extension UneGrilleAvecContenu {
    
    static func cases(ligne: Ligne) -> [Case] {
        ligne.lesCases
    }
    
    static func cases(colonne: Colonne) -> [Case] {
        colonne.lesCases
    }
    
    static func cases(carre: Carre) -> [Case] {
        carre.lesCases
    }
    
    static func ligne(_ cellule: Case) -> Ligne {
        Ligne(cellule.indexLigne)
    }
    
    static func colonne(_ cellule: Case) -> Colonne {
        Colonne(cellule.indexColonne)
    }
    
    static func carre(_ cellule: Case) -> Carre {
        Carre(cellule.indexLigne / 3, cellule.indexColonne / 3)
    }
    
    static func indexLigne(_ cellule: Case) -> Int {
        ligne(cellule).index
    }

    static func indexColonne(_ cellule: Case) -> Int {
        colonne(cellule).index
    }

}
