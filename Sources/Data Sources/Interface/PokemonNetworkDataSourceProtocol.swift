//
//  PokemonNetworkDataSourceProtocol.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

protocol PokemonNetworkDataSourceProtocol {
    
    func getPokemonSpecies(of name: String) async throws -> PokemonSpecies
    
    func getPokemon(of name: String) async throws -> Pokemon
}
