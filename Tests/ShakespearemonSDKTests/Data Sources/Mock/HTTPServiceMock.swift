//
//  HTTPServiceMock.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

@testable import ShakespearemonSDK

struct HTTPServiceMock: HTTPServiceProtocol {
    
    let basePath: String = "mockBasePath"
    
    private let testCase: PokemonNetworkDataSourceTestCase
    
    init(testCase: PokemonNetworkDataSourceTestCase) {
        self.testCase = testCase
    }
    
    func fetch<Result: Decodable>(using request: any HTTPRequestProtocol) async throws -> Result {
        switch testCase {
        case .pokemon:
            return initPokemon() as! Result
        case .pokemonSpecies:
            return initPokemonSpecies() as! Result
        }
    }
    
    private func initPokemon() -> Pokemon {
        let pokemon: Pokemon? = ShakespearemonSDKTests.loadJson(filename: "PokemonMock")
        
        guard let pokemon else {
            fatalError("Error decoding from PokemonMock.json")
        }
        
        return pokemon
    }
    
    private func initPokemonSpecies() -> PokemonSpecies {
        let species: PokemonSpecies? = ShakespearemonSDKTests.loadJson(filename: "PokemonSpeciesMock")
        
        guard let species else {
            fatalError("Error decoding from PokemonSpeciesMock.json")
        }
        
        return species
    }
}
