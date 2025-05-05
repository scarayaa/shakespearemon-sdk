//
//  PokemonNetworkDataSourceProtocol.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

/// A data source interface used to define required methods
/// to fetch pokémon data from network.
protocol PokemonNetworkDataSourceProtocol {
    
    /// Retrieves a Pokémon species from the specified name.
    ///
    /// - Parameters:
    ///     - name: The name of the Pokémon.
    /// - Returns:
    ///     A `PokemonSpecies` data containing relevant informations about the Pokémon species.
    func getPokemonSpecies(of name: String) async throws -> PokemonSpecies
    
    /// Retrieves a Pokémon from the given name.
    ///
    /// - Parameters:
    ///     - name: The name of the Pokémon.
    /// - Returns:
    ///     A `Pokemon` structure containing relevant informations about the Pokémon.
    func getPokemon(of name: String) async throws -> Pokemon
}
