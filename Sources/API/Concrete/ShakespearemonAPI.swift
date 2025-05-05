//
//  ShakespearemonAPI.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import Foundation.NSURL

/// The internal implementation of `ShakespearemonService`.
final class ShakespearemonAPI: ShakespearemonService {
    
    private let shakespearemonRepository: any ShakespearemonRepositoryProtocol
    
    init(shakespearemonRepository: any ShakespearemonRepositoryProtocol) {
        self.shakespearemonRepository = shakespearemonRepository
    }
    
    func getShakespeareanDescription(ofPokemon name: String) async throws -> String {
        try await shakespearemonRepository.getShakespeareanDescription(ofPokemon: name)
    }
    
    func getPokemonSpriteURL(ofPokemon name: String) async throws -> URL {
        try await shakespearemonRepository.getPokemonSpriteURL(ofPokemon: name)
    }
}
