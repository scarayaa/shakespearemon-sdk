//
//  PokemonRepository.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import Foundation.NSURL

protocol PokemonRepositoryProtocol {
    
    func getShakespeareanDescription(ofPokemon name: String) async throws -> String
    
    func getPokemonSpriteURL(ofPokemon name: String) async throws -> URL
}
