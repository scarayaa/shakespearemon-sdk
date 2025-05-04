//
//  PokemonSpecies.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import Foundation.NSData

struct PokemonSpecies: Decodable {
    let flavorTextEntries: [FlavorTextEntry]
    
    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.flavorTextEntries = try container.decode([FlavorTextEntry].self, forKey: .flavorTextEntries)
    }
}

extension PokemonSpecies {
    
    struct FlavorTextEntry: Decodable {
        let flavorText: String
        let language: Language
        
        var cleanedFlavorText: String {
            cleanFlavorText(flavorText)
        }
        
        enum CodingKeys: String, CodingKey {
            case flavorText = "flavor_text"
            case language
        }
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.flavorText = try container.decode(String.self, forKey: .flavorText)
            self.language = try container.decode(Language.self, forKey: .language)
        }
        
        private func cleanFlavorText(_ text: String) -> String {
            text.replacingOccurrences(of: "\u{c}", with: "\n")
                .replacingOccurrences(of: "\u{ad}\n", with: "")
                .replacingOccurrences(of: "\u{ad}", with: "")
                .replacingOccurrences(of: " -\n", with: " - ")
                .replacingOccurrences(of: "-\n", with: "-")
                .replacingOccurrences(of: "\n", with: " ")
        }
    }
}

extension PokemonSpecies.FlavorTextEntry {
    
    struct Language: Decodable {
        let name: String
        let url: String
    }
}
