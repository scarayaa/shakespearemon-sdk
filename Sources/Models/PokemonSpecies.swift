//
//  PokemonSpecies.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

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
        
        enum CodingKeys: String, CodingKey {
            case flavorText = "flavor_text"
            case language
        }
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.flavorText = try container.decode(String.self, forKey: .flavorText)
            self.language = try container.decode(Language.self, forKey: .language)
        }
    }
}

extension PokemonSpecies.FlavorTextEntry {
    
    struct Language: Decodable {
        let name: String
        let url: String
    }
}
