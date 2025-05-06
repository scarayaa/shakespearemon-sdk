//
//  PokemonNetworkDataSourceMock.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

@testable import ShakespearemonSDK

struct PokemonNetworkDataSourceMock: PokemonNetworkDataSourceProtocol {
    
    private let testcase: RepositoryTestCase
    
    init(testcase: RepositoryTestCase) {
        self.testcase = testcase
    }
    
    func getPokemonSpecies(of name: String) async throws -> PokemonSpecies {
        switch testcase {
        case .pokemonshakespeareanDescription(let languageCode):
            mockPokemonSpecies(languageCode: languageCode)
        default:
            fatalError("Unhandled test case.")
        }
    }
    
    func getPokemon(of name: String) async throws -> Pokemon {
        switch testcase {
        case .pokemonSpriteURL:
            mockPokemon()
        case .pokemonSpriteURLMalformed:
            mockPokemonMalformedURL()
        default:
            fatalError("Unhandled test case.")
        }
    }
    
    private func mockPokemon() -> Pokemon {
        Pokemon(
            sprites: Pokemon.Sprites(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/35.png"
            )
        )
    }
    
    private func mockPokemonMalformedURL() -> Pokemon {
        Pokemon(
            sprites: Pokemon.Sprites(
                frontDefault: ""
            )
        )
    }
    
    private func mockPokemonSpecies(languageCode: String) -> PokemonSpecies {
        PokemonSpecies(
            flavorTextEntries: [
                PokemonSpecies.FlavorTextEntry(
                    flavorText: "Spits fire that\nis hot enough to\nmelt boulders.\u{c}Known to cause\nforest fires\nunintentionally.",
                    language: PokemonSpecies.FlavorTextEntry.Language(
                        name: languageCode
                    )
                )
            ]
        )
    }
}
