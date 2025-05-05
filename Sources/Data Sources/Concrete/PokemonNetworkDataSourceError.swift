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
    
    var errorDescription: String? {
        switch self {
        case .maxNameLengthLimit:
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
