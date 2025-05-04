//
//  PokemonNetworkDataSourceError.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import Foundation.NSError

enum PokemonNetworkDataSourceError: ShakespearemonError {
    case maxNameLengthLimit(max: Int, exceeded: Int)
    
    var errorDescription: String? {
        switch self {
        case .maxNameLengthLimit(let max, let exceeded):
            "Pokémon name is too long."
        }
    }
    
    var description: String {
        switch self {
        case .maxNameLengthLimit(let max, let exceeded):
            "The maximum pokémon name's length (\(max)) has exceeded (\(exceeded))."
        }
    }
}
