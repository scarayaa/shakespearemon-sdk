//
//  Shakespearemon.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

public final class Shakespearemon: ShakespearemonAPI {
    
    private let BASE_PATH_POKEAPI = "https://pokeapi.co/api/v2"
    private let BASE_PATH_FUNTRANSLATIONS = "https://api.funtranslations.com/translate"
    
    private let pokemonRepository: any PokemonRepositoryProtocol
    
    public init() {
        let pokeApiHttpService = HTTPService(basePath: BASE_PATH_POKEAPI)
        let funTransationsHttpService = HTTPService(basePath: BASE_PATH_FUNTRANSLATIONS)
        
        let pokemonDataSource = PokemonNetworkDataSource(httpService: pokeApiHttpService)
        let translationsDataSource = TranslationsNetworkDataSource(httpService: funTransationsHttpService)
        
        self.pokemonRepository = PokemonRepository(
            pokemonDataSource: pokemonDataSource,
            translationsDataSource: translationsDataSource
        )
    }
    
    public func getShakespeareanDescription(ofPokemon name: String) async throws -> String {
        try await pokemonRepository.getShakespeareanDescription(ofPokemon: name)
    }
    
    public func getPokemonSpriteURL(ofPokemon name: String) async throws -> String {
        try await pokemonRepository.getPokemonSpriteURL(ofPokemon: name)
    }
}
