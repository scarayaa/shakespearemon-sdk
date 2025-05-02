//
//  PokemonNetworkDataSource.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

final class PokemonNetworkDataSource: PokemonNetworkDataSourceProtocol {
    
    private let httpService: any HTTPServiceProtocol
    
    init(httpService: any HTTPServiceProtocol) {
        self.httpService = httpService
    }
    
    func getPokemonSpecies(of name: String) async throws -> PokemonSpecies {
        try await PokeAPIOperations.GetPokemonSpecies(
            httpService: httpService,
            name: name
        ).run()
    }
    
    func getPokemon(of name: String) async throws -> Pokemon {
        try await PokeAPIOperations.GetPokemon(
            httpService: httpService,
            name: name
        ).run()
    }
}
