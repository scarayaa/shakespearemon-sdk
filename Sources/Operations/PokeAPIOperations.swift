//
//  PokeAPIOperations.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

enum PokeAPIOperations {
    
    struct GetPokemon: HTTPOperation {
        
        typealias Result = Pokemon
        
        let method: HTTPMethod = .get
        
        let path: String
        
        let queryParameters: [String : String] = [:]
        
        let httpService: any HTTPServiceProtocol
        
        init(httpService: any HTTPServiceProtocol, name: String) {
            self.httpService = httpService
            path = "pokemon/\(name)"
        }
    }
    
    struct GetPokemonSpecies: HTTPOperation {
        
        typealias Result = PokemonSpecies
        
        let method: HTTPMethod = .get
        
        let path: String
        
        let queryParameters: [String : String] = [:]
        
        let httpService: any HTTPServiceProtocol
        
        init(httpService: any HTTPServiceProtocol, name: String) {
            self.httpService = httpService
            path = "pokemon-species/\(name)"
        }
    }
}
