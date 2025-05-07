//
//  ShakespeareanRepository.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

import XCTest
@testable import ShakespearemonSDK

final class ShakespearemonRepositoryTests: XCTestCase {
    
    func testGetshakespeareanDescriptionOfPokemon() async throws {
        let testCase = RepositoryTestCase.pokemonshakespeareanDescription(languageCode: "en")
        let mockPokemonDataSource = PokemonNetworkDataSourceMock(testcase: testCase)
        let mockTranslationsDataSource = TranslationsNetworkDataSourceMock(testcase: testCase)
        let sut = ShakespearemonRepository(
            pokemonDataSource: mockPokemonDataSource,
            translationsDataSource: mockTranslationsDataSource
        )
        
        // Name can be anything. Mock is returning always the same result.
        let translatedDescription = try await sut.getShakespeareanDescription(ofPokemon: "Clefairy")
        let expectedDescription = "Thee did giveth mr. Tim a hearty meal,  but unfortunately what he did doth englut did maketh him kicketh the bucket."
        XCTAssertEqual(translatedDescription, expectedDescription)
    }
    
    func testGetshakespeareanDescriptionOfMissingEnglish() async throws {
        let testCase = RepositoryTestCase.pokemonshakespeareanDescription(languageCode: "it")
        let mockPokemonDataSource = PokemonNetworkDataSourceMock(testcase: testCase)
        let mockTranslationsDataSource = TranslationsNetworkDataSourceMock(testcase: testCase)
        let sut = ShakespearemonRepository(
            pokemonDataSource: mockPokemonDataSource,
            translationsDataSource: mockTranslationsDataSource
        )
        
        do {
            // Name can be anything. Mock is returning always the same result.
            let translatedDescription = try await sut.getShakespeareanDescription(ofPokemon: "Clefairy")
            XCTFail("Method should return language error, but returned sucessfully (\(translatedDescription))")
        } catch let error as ShakespearemonRepositoryError {
            switch error {
            case .englishDescriptionNotFound:
                // No asserts to be done. Error is correct.
                ()
            default:
                XCTFail("Unexpected error from ShakespearemonRepository (\(error.localizedDescription))")
            }
        }
    }
    
    func testGetPokemonSpriteURL() async throws {
        let testCase = RepositoryTestCase.pokemonSpriteURL
        let mockPokemonDataSource = PokemonNetworkDataSourceMock(testcase: testCase)
        let mockTranslationsDataSource = TranslationsNetworkDataSourceMock(testcase: testCase)
        let sut = ShakespearemonRepository(
            pokemonDataSource: mockPokemonDataSource,
            translationsDataSource: mockTranslationsDataSource
        )
        
        // Name can be anything. Mock is returning always the same result.
        let url = try await sut.getPokemonSpriteURL(ofPokemon: "Clefairy")
        let expectedUrlString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/35.png"
        XCTAssertEqual(url.absoluteString, expectedUrlString)
    }
    
    func testGetPokemonSpriteURLMalformed() async throws {
        let testCase = RepositoryTestCase.pokemonSpriteURLMalformed
        let mockPokemonDataSource = PokemonNetworkDataSourceMock(testcase: testCase)
        let mockTranslationsDataSource = TranslationsNetworkDataSourceMock(testcase: testCase)
        let sut = ShakespearemonRepository(
            pokemonDataSource: mockPokemonDataSource,
            translationsDataSource: mockTranslationsDataSource
        )
        
        do {
            // Name can be anything. Mock is returning always the same result.
            let url = try await sut.getPokemonSpriteURL(ofPokemon: "Clefairy")
            XCTFail("Method should return malformed url error, but returned sucessfully (\(url))")
        } catch let error as ShakespearemonRepositoryError {
            switch error {
            case .spriteUrlMalformed(let string):
                let expectedMalformedUrlString = ""
                XCTAssertEqual(string, expectedMalformedUrlString)
            default:
                XCTFail("Unexpected error from ShakespearemonRepository (\(error.localizedDescription))")
            }
        }        
    }
}
