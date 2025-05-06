//
//  PokemonNetworkDataSourceError.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import Foundation.NSError

/// Represents a list of explicit errors that may thrown by the corresponding data source.
enum PokemonNetworkDataSourceError: ShakespearemonError {
    /// The maximum lenght permitted for the Pokémon's name has been exceeded.
    case maxNameLengthLimit(max: Int, exceeded: Int)
    /// The minimum lenght permitted for the Pokémon's name has not been met.
    case minNameLengthLimit(min: Int, inserted: Int)
    
    var errorDescription: String? {
        switch self {
        case .maxNameLengthLimit:
            "Pokémon name is too long."
        case .minNameLengthLimit:
            "Pokémon name is too short."
        }
    }
    
    var description: String {
        switch self {
        case .maxNameLengthLimit(let max, let exceeded):
            "The maximum pokémon name's length (\(max)) has exceeded (\(exceeded))."
        case .minNameLengthLimit(let min, let inserted):
            "The minimum pokémon name's length (\(min)) hasn't been reached (\(inserted))."
        }
    }
}
