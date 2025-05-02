//
//  Pokemon.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

struct Pokemon: Decodable {
    let sprites: Sprites
}

extension Pokemon {
    
    struct Sprites: Decodable {
        let frontDefault: String
        
        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.frontDefault = try container.decode(String.self, forKey: .frontDefault)
        }
    }
}
