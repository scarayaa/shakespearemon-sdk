//
//  ShakespereamonAPI.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

public protocol ShakespearemonAPI {
    
    init()
    
    func getShakespeareanDescription(ofPokemon name: String) async throws -> String
    
    func getPokemonSpriteURL(ofPokemon name: String) async throws -> String
}
