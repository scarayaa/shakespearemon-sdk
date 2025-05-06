//
//  HTTPServiceMock.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

@testable import ShakespearemonSDK

struct HTTPServiceMock: HTTPServiceProtocol {
    
    let basePath: String = "mockBasePath"
    
    private let testCase: NetworkDataSourceTestCase
    
    init(testCase: NetworkDataSourceTestCase) {
        self.testCase = testCase
    }
    
    func fetch<Result: Decodable>(using request: any HTTPRequestProtocol) async throws -> Result {
        switch testCase {
        case .pokemon(let pokemon):
            pokemon as! Result
        case .pokemonSpecies(let pokemonSpecies):
            pokemonSpecies as! Result
        case .shakespeareanTranslation(let translation):
            translation as! Result
        }
    }
}
