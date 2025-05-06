//
//  ShakespearemonAPITests.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

import XCTest
@preconcurrency import RealHTTP
@testable import ShakespearemonSDK

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
        let data = jsonData(fromFile: "GetPokemonSpriteURL")
        
        let pokemonStub = try HTTPStubRequest()
            .match(urlRegex: "/pokemon/Clefairy")
            .stub(for: .get, code: .accepted, contentType: .json, body: data.jsonString())
        
        stubber.add(stub: pokemonStub)
        
        let spriteURL = try await sut.getPokemonSpriteURL(ofPokemon: "Clefairy")
        let expectedURLString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/35.png"
        XCTAssertEqual(spriteURL.absoluteString, expectedURLString)
    }
    
    func testGetPokemonSpriteURLMalformed() async throws {
        let data = jsonData(fromFile: "PokemonMock")
        
        let pokemonStub = try HTTPStubRequest()
            .match(urlRegex: "/pokemon/Clefairy")
            .stub(for: .get, code: .accepted, contentType: .json, body: data.jsonString())
        
        stubber.add(stub: pokemonStub)
        
        let spriteURL = try await sut.getPokemonSpriteURL(ofPokemon: "Clefairy")
        let expectedURLString = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/35.png"
        XCTAssertEqual(spriteURL.absoluteString, expectedURLString)
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
