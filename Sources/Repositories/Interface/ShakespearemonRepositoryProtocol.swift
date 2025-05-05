//
//  ShakespearemonRepositoryProtocol.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import Foundation.NSURL

/// A repository interface used to define required methods
/// to fetch all needed for showing a Shakespearean Pokémon detail.
protocol ShakespearemonRepositoryProtocol {
    
    /// Gets an english flavored text of the given pokémon name translated into its
    /// shakespearean version.
    ///
    /// - Parameters:
    ///     - name: The name of the pokémon.
    /// - Returns:
    ///     - The retrieved description.
    func getShakespeareanDescription(ofPokemon name: String) async throws -> String
    
    /// Gets the sprite's URL of the given pokémon name.
    ///
    /// - Parameters:
    ///     - name: The name of the pokémon.
    /// - Returns:
    ///     - The image's URL.
    func getPokemonSpriteURL(ofPokemon name: String) async throws -> URL
}
