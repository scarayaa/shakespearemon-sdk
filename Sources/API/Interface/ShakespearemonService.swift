//
//  ShakespearemonService.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import Foundation.NSURL

/// The Shakespearemon service interface. Defines all required API methods to
/// fetch the needed pokémon data.
public protocol ShakespearemonService {
        
    /// Gets an english flavored text of the given pokémon name translated into its
    /// shakespearean version.
    ///
    /// - Parameters:
    ///     - name: The name of the pokémon.
    /// - Returns:
    ///     - The retrieved description.
    /// - Throws:
    ///     - A `ShakespeareanError` conforming type.
    func getShakespeareanDescription(ofPokemon name: String) async throws -> String
    
    /// Gets the sprite's URL of the given pokémon name.
    ///
    /// - Parameters:
    ///     - name: The name of the pokémon.
    /// - Returns:
    ///     - The image's URL.
    /// - Throws:
    ///     - A `ShakespeareanError` conforming type.
    func getPokemonSpriteURL(ofPokemon name: String) async throws -> URL
}
