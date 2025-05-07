//
//  ShakespearemonAPITests.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

import XCTest
@preconcurrency import RealHTTP
@testable import ShakespearemonSDK

/// A group of integration tests, using RealHTTP dependency to stub underlying
/// URLSession network calls and check expected outcomes.
class ShakespearemonAPITests: XCTestCase {
    
    let stubber = HTTPStubber.shared
    
    let sut = ShakespearemonSDK.getNewServiceInstance()
        
    override func setUp() {
        stubber.enable()
    }
    
    override func tearDown() {
        stubber.removeAllStubs()
        stubber.disable()
    }
    
    func testGetPokemonSpriteURL() async throws {
        let data = jsonData(fromFile: "pokemon")
        
        let pokemonStub = try HTTPStubRequest()
            .match(urlRegex: "/pokemon/Clefairy")
            .stub(for: .get, code: .accepted, contentType: .json, body: data.jsonString())
        
        stubber.add(stub: pokemonStub)
        
        let spriteURL = try await sut.getPokemonSpriteURL(ofPokemon: "Clefairy")
        let expectedURLString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/35.png"
        XCTAssertEqual(spriteURL.absoluteString, expectedURLString)
    }
    
    func testGetPokemonSpriteURLMalformed() async throws {
        let data = jsonData(fromFile: "pokemon_malformed_url")
        
        let pokemonStub = try HTTPStubRequest()
            .match(urlRegex: "/pokemon/Clefairy")
            .stub(for: .get, code: .accepted, contentType: .json, body: data.jsonString())
        
        stubber.add(stub: pokemonStub)
        
        do {
            let spriteURL = try await sut.getPokemonSpriteURL(ofPokemon: "Clefairy")
            XCTFail("Method should return malformed url error, but returned sucessfully (\(spriteURL))")
        } catch let error as ShakespearemonRepositoryError {
            switch error {
            case .spriteUrlMalformed(let string):
                let expectedMalformedUrlString = ""
                XCTAssertEqual(string, expectedMalformedUrlString)
            default:
                XCTFail("Unexpected error from ShakespearemonAPI (\(error.localizedDescription))")
            }
        }
    }
    
    func testGetPokemonSpriteURL404() async throws {
        let pokemonStub = try HTTPStubRequest()
            .match(urlRegex: "/pokemon/Charizard")
            .stub(for: .get, code: .notFound, contentType: .json, body: .none)
        
        stubber.add(stub: pokemonStub)
        
        do {
            let spriteURL = try await sut.getPokemonSpriteURL(ofPokemon: "Charizard")
            XCTFail("Method should return 404 client error, but returned sucessfully (\(spriteURL))")
        } catch let error as HTTPServiceError {
            switch error {
            case .clientError(let statusCode) where statusCode == .notFound:
                // Correct error
                ()
            default:
                XCTFail("Expected `.clientError(.notFound)` but found error: \(error.localizedDescription)")
            }
        }
    }
    
    func testGetPokemonSpriteURL429() async throws {
        let pokemonStub = try HTTPStubRequest()
            .match(urlRegex: "/pokemon/Charizard")
            .stub(for: .get, code: .tooManyRequests, contentType: .json, body: .none)
        
        stubber.add(stub: pokemonStub)
        
        do {
            let spriteURL = try await sut.getPokemonSpriteURL(ofPokemon: "Charizard")
            XCTFail("Method should return 429 client error, but returned sucessfully (\(spriteURL))")
        } catch let error as HTTPServiceError {
            switch error {
            case .clientError(let statusCode) where statusCode == .tooManyRequests:
                // Correct error
                ()
            default:
                XCTFail("Expected `.clientError(.tooManyRequests)` but found error: \(error.localizedDescription)")
            }
        }
    }
    
    func testGetPokemonSpriteURLGenericError() async throws {
        let pokemonStub = try HTTPStubRequest()
            .match(urlRegex: "/pokemon/Charizard")
            .stub(for: .get, code: .internalServerError, contentType: .json, body: .none)
        
        stubber.add(stub: pokemonStub)
        
        do {
            let spriteURL = try await sut.getPokemonSpriteURL(ofPokemon: "Charizard")
            XCTFail("Expected an HTTPError, but method returned sucessfully \(spriteURL)")
        } catch let error as HTTPError {
            // Just making sure that status code corresponds to the one specified in the mock.
            // The test is the same for any different status code from the ones specified.
            XCTAssertEqual(error.statusCode, .internalServerError)
        } catch {
            XCTFail("Expected an HTTPError but found error of type \(error.self)")
        }
    }
    
    func testGetPokemonSpriteURLLengthError() async throws {
        let data = jsonData(fromFile: "pokemon")
        
        let pokemonStub = try HTTPStubRequest()
            .match(urlRegex: "/pokemon")
            .stub(for: .get, code: .accepted, contentType: .json, body: data.jsonString())
        
        stubber.add(stub: pokemonStub)
        
        try await checkLengthErrorForTestCase(.getPokemonSpriteURL)
    }
    
    func testGetShakespeareanDescription() async throws {
        let pokemonSpeciesData = jsonData(fromFile: "pokemonspecies")
        let translationData = jsonData(fromFile: "translation")
        
        let pokemonSpeciesStub = try HTTPStubRequest()
            .match(urlRegex: "/pokemon-species/Charizard")
            .stub(for: .get, code: .accepted, contentType: .json, body: pokemonSpeciesData)
        
        let translationStub = try HTTPStubRequest()
            .match(urlRegex: "/shakespeare.json")
            .stub(for: .get, code: .accepted, contentType: .json, body: translationData)
        
        stubber.add(stub: pokemonSpeciesStub)
        stubber.add(stub: translationStub)
        
        let translatedDescription = try await sut.getShakespeareanDescription(ofPokemon: "Charizard")
        let expectedDescription = "Thee did giveth mr. Tim a hearty meal,  but unfortunately what he did doth englut did maketh him kicketh the bucket."
        XCTAssertEqual(translatedDescription, expectedDescription)
    }
    
    func testGetShakespeareanDescriptionMissingEnglishCode() async throws {
        let pokemonSpeciesData = jsonData(fromFile: "pokemonspecies_missing_en")
        
        let pokemonSpeciesStub = try HTTPStubRequest()
            .match(urlRegex: "/pokemon-species/Charizard")
            .stub(for: .get, code: .accepted, contentType: .json, body: pokemonSpeciesData)
        
        stubber.add(stub: pokemonSpeciesStub)
        
        do {
            let translatedDescription = try await sut.getShakespeareanDescription(ofPokemon: "Charizard")
            XCTFail("Method should return language error, but returned sucessfully (\(translatedDescription))")
        } catch let error as ShakespearemonRepositoryError {
            switch error {
            case .englishDescriptionNotFound:
                // No asserts to be done. Error is correct.
                ()
            default:
                XCTFail("Unexpected error from ShakespearemonAPI (\(error.localizedDescription))")
            }
        }
    }
    
    func testGetShakespeareanDescriptionLengthError() async throws {
        let pokemonSpeciesData = jsonData(fromFile: "pokemonspecies")
        let translationData = jsonData(fromFile: "translation")
        
        let pokemonSpeciesStub = try HTTPStubRequest()
            .match(urlRegex: "/pokemon-species")
            .stub(for: .get, code: .accepted, contentType: .json, body: pokemonSpeciesData)
        
        let translationStub = try HTTPStubRequest()
            .match(urlRegex: "/shakespeare.json")
            .stub(for: .get, code: .accepted, contentType: .json, body: translationData)
        
        stubber.add(stub: pokemonSpeciesStub)
        stubber.add(stub: translationStub)
        
        try await checkLengthErrorForTestCase(.getShakespereanDescription)
    }
    
    private func checkLengthErrorForTestCase(_ testCase: LengthErrorTestCase) async throws {
        let minLength = 3
        let maxLength = 12
        
        for length in 0...15 {
            let name = "".padding(toLength: length, withPad: "a", startingAt: 0)
            do {
                switch testCase {
                case .getShakespereanDescription:
                    _ = try await sut.getShakespeareanDescription(ofPokemon: name)
                case .getPokemonSpriteURL:
                    _ = try await sut.getPokemonSpriteURL(ofPokemon: name)
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
}

extension ShakespearemonAPITests {
    
    enum LengthErrorTestCase {
        case getShakespereanDescription
        case getPokemonSpriteURL
    }
    
    private func jsonData(fromFile name: String) -> Data {
        let bundle = Bundle.module
        
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            fatalError("jsonData resource not found")
        }
        
        do {
            return try Data(contentsOf: url)
        } catch {
            fatalError("jsonData error: \(error)")
        }
    }
}
