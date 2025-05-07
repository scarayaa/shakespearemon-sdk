//
//  PokemonNetworkDataSourceTests.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

import XCTest
@testable import ShakespearemonSDK

final class PokemonNetworkDataSourceTests: XCTestCase {
    
    /// Tests the correct retrieval of a Pokemon structure in a success environment.
    func testGetPokemon() async throws {
        let mockedPokemon = mockPokemon()
        let mockHttpService = HTTPServiceMock(testCase: .pokemon(mockedPokemon))
        let sut = PokemonNetworkDataSource(httpService: mockHttpService)
        
        // Name can be anything in the 3-12 length range. Mock is returning always the same response. This
        // only tests the correct get of the Pokemon structure.
        let pokemon = try await sut.getPokemon(of: "Clefairy")
        let expectedUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/35.png"
        XCTAssertEqual(pokemon.sprites.frontDefault, expectedUrl)
    }
    
    /// Tests the correct retrieval of a Pokemon Species structure in a success environment.
    /// NOTE: this also covers a test case of `PokemonSpecies.cleanedFlavorText`. A different
    /// unit test for it wpuld be good in the future.
    func testGetPokemonSpecies() async throws {
        let mockedPokemonSpecies = mockPokemonSpecies()
        let mockHttpService = HTTPServiceMock(testCase: .pokemonSpecies(mockedPokemonSpecies))
        let sut = PokemonNetworkDataSource(httpService: mockHttpService)
        
        // Name can be anything in the 3-12 length range. Mock is returning always the same response. This
        // only tests the correct get of the Pokemon Species structure given a success response.
        let pokemonSpecies = try await sut.getPokemonSpecies(of: "Charizard")
        
        guard let entry = pokemonSpecies.flavorTextEntries.first else {
            XCTFail("Unexpectedly found no flavor text entries.")
            return
        }
        
        // The expected "cleaned" text
        let expectedFlavorText = "Spits fire that is hot enough to melt boulders. Known to cause forest fires unintentionally."
        XCTAssertEqual(entry.cleanedFlavorText, expectedFlavorText)
    }
    
    func testPokemonNameLength() async throws {
        try await checkPokemonNameLength(for: .pokemon(mockPokemon()))
        try await checkPokemonNameLength(for: .pokemonSpecies(mockPokemonSpecies()))
    }
    
    private func checkPokemonNameLength(for testCase: NetworkDataSourceTestCase) async throws {
        let mockHttpService = HTTPServiceMock(testCase: testCase)
        let sut = PokemonNetworkDataSource(httpService: mockHttpService)
        
        let minLength = 3
        let maxLength = 12
        
        for length in 0...15 {
            let name = "".padding(toLength: length, withPad: "a", startingAt: 0)
            do {
                switch testCase {
                case .pokemon:
                    _ = try await sut.getPokemon(of: name)
                case .pokemonSpecies:
                    _ = try await sut.getPokemonSpecies(of: name)
                default:
                    // Shouldn't happen
                    return
                }
                
                if !(3...12).contains(length) {
                    XCTFail("The Pokémon length name wasn't in the correct range (\(length)), but no error was thrown")
                }
            } catch let error as PokemonNetworkDataSourceError {
                if length < 3, case .minNameLengthLimit(let min, let inserted) = error {
                    XCTAssertEqual(min, minLength)
                    XCTAssertEqual(inserted, length)
                } else if length > 12, case .maxNameLengthLimit(let max, let exceeded) = error {
                    XCTAssertEqual(max, maxLength)
                    XCTAssertEqual(exceeded, length)
                } else if (3...12).contains(length) {
                    XCTFail("A Pokémon length name error was thrown, but the name is in the correct range (\(length))")
                }
            } catch {
                XCTFail("Unexpected error from PokemonNetworkDataSource")
            }
        }
    }
    
    private func mockPokemon() -> Pokemon {
        Pokemon(
            sprites: Pokemon.Sprites(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/35.png"
            )
        )
    }
    
    private func mockPokemonSpecies() -> PokemonSpecies {
        PokemonSpecies(
            flavorTextEntries: [
                PokemonSpecies.FlavorTextEntry(
                    flavorText: "Spits fire that\nis hot enough to\nmelt boulders.\u{c}Known to cause\nforest fires\nunintentionally.",
                    language: PokemonSpecies.FlavorTextEntry.Language(
                        name: "en"
                    )
                )
            ]
        )
    }
}
