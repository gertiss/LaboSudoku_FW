//
//  PaireUneValeurDeuxCases.swift
//  LaboSudoku_FW
//
//  Created by Gérard Tisseau on 28/01/2023.
//

import Foundation

public struct AnnotationPaireUneValeurDeuxCases: Hashable {
    public var valeur: Int
    public var paireDeCases: Set<Case>
    
    public init(valeur: Int, paireDeCases: Set<Case>) {
        assert(paireDeCases.count == 2)
        self.valeur = valeur
        self.paireDeCases = paireDeCases
    }
}

/// Cela représente le fait : "il existe une zone dans laquelle telle valeur ne peut aller que dans telle paire de cases"
/// la zone est donnée par `zone`
/// la valeur est donnée par `valeur`
/// la paire de cases est donnée par `paireDeCases`
/// Ce fait se trouve par la stratégie `.rechercheDeCasesPourValeur`
/// La focalisation se fait sur la valeur et sur la zone : `FocalisationValeurZone.avec(valeur, zone)`
/// Ce fait permet de créer une annotation  identifiée par (valeur, paireDeCases)
public struct PaireUneValeurDeuxCases: Hashable, Codable {
    public var paireDeCases: Set<Case>
    public var focalisation: FocalisationValeurZone
    
    public init(paireDeCases: Set<Case>, focalisation: FocalisationValeurZone) {
        assert(paireDeCases.count == 2)
        self.paireDeCases = paireDeCases
        self.focalisation = focalisation
    }
}

public extension PaireUneValeurDeuxCases {
    
    /// L'annotation qui peut être affirmée quand on détecte la paire
    var annotation: AnnotationPaireUneValeurDeuxCases {
        AnnotationPaireUneValeurDeuxCases(valeur: valeur, paireDeCases: paireDeCases)
    }
    
    var strategie: Strategie {
        .rechercheDeCasesPourValeur
    }
    
    var valeur: Int {
        focalisation.valeur
    }
    
    var zone: any UneZone {
        focalisation.zone
    }
    
    /// Exemple :  "Aa-Ab"
    var texteCases: String {
        paireDeCases.map { $0.nom }
            .sorted()
            .joined(separator: "-")
    }
    
    var explication: String {
        "\(valeur) ? \(texteCases) dans \(zone.nom)"
    }
}

public extension Set<PaireUneValeurDeuxCases> {
    
    var parOrdreDeValeurs: [PaireUneValeurDeuxCases] {
        let liste = map { $0 }
        return liste.sorted { paire1, paire2 in
            paire1.valeur < paire2.valeur
        }
    }
}

