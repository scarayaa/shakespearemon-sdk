//
//  PokemonNetworkDataSource.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

final class PokemonNetworkDataSource: PokemonNetworkDataSourceProtocol {
    
    private let httpService: any HTTPServiceProtocol
    
    private let maxNameLength = 12
    private let minNameLength = 3
    
    init(httpService: any HTTPServiceProtocol) {
        self.httpService = httpService
    }
    
    func getPokemonSpecies(of name: String) async throws -> PokemonSpecies {
        guard name.count <= maxNameLength else {
            throw PokemonNetworkDataSourceError.maxNameLengthLimit(
                max: maxNameLength,
                exceeded: name.count
            )
        }
        
        guard name.count >= minNameLength else {
            throw PokemonNetworkDataSourceError.minNameLengthLimit(
                min: minNameLength,
                inserted: name.count
            )
        }
        
        return try await PokeAPIOperations.GetPokemonSpecies(
            httpService: httpService,
            name: name
        ).run()
    }
    
    func getPokemon(of name: String) async throws -> Pokemon {
        guard name.count <= maxNameLength else {
            throw PokemonNetworkDataSourceError.maxNameLengthLimit(
                max: maxNameLength,
                exceeded: name.count
            )
        }
        
        guard name.count >= minNameLength else {
            throw PokemonNetworkDataSourceError.minNameLengthLimit(
                min: minNameLength,
                inserted: name.count
            )
        }
        
        return try await PokeAPIOperations.GetPokemon(
            httpService: httpService,
            name: name
        ).run()
    }
}
