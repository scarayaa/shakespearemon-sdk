//
//  ShakespearemonAPI.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import Foundation.NSURL

final class ShakespearemonAPI: ShakespearemonService {
    
    private let BASE_PATH_POKEAPI = "https://pokeapi.co/api/v2"
    private let BASE_PATH_FUNTRANSLATIONS = "https://api.funtranslations.com/translate"
    
    private let pokemonRepository: any PokemonRepositoryProtocol
    
    init() {
        let pokeApiHttpService = HTTPService(basePath: BASE_PATH_POKEAPI)
        let funTransationsHttpService = HTTPService(basePath: BASE_PATH_FUNTRANSLATIONS)
        
        let pokemonDataSource = PokemonNetworkDataSource(httpService: pokeApiHttpService)
        let translationsDataSource = TranslationsNetworkDataSource(httpService: funTransationsHttpService)
        
        self.pokemonRepository = PokemonRepository(
            pokemonDataSource: pokemonDataSource,
            translationsDataSource: translationsDataSource
        )
    }
    
    func getShakespeareanDescription(ofPokemon name: String) async throws -> String {
        try await pokemonRepository.getShakespeareanDescription(ofPokemon: name)
    }
    
    func getPokemonSpriteURL(ofPokemon name: String) async throws -> URL {
        try await pokemonRepository.getPokemonSpriteURL(ofPokemon: name)
    }
}
