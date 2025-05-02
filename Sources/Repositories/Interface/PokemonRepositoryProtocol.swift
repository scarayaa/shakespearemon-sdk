//
//  PokemonRepository.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

protocol PokemonRepositoryProtocol {
    
    func getShakespereanDescription(ofPokemon name: String) async throws -> String
    
    func getPokemonSpriteURL(ofPokemon name: String) async throws -> String
}
