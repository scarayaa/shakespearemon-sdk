//
//  ShakespearemonRepository.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import Foundation.NSURL

final class ShakespearemonRepository: ShakespearemonRepositoryProtocol {
    
    private let pokemonDataSource: PokemonNetworkDataSourceProtocol
    private let translationsDataSource: TranslationsNetworkDataSourceProtocol
    
    init(
        pokemonDataSource: PokemonNetworkDataSourceProtocol,
        translationsDataSource: TranslationsNetworkDataSourceProtocol
    ) {
        self.pokemonDataSource = pokemonDataSource
        self.translationsDataSource = translationsDataSource
    }
    
    func getShakespeareanDescription(ofPokemon name: String) async throws -> String {
        let pokemonSpecies = try await pokemonDataSource.getPokemonSpecies(of: name)
        
        // At least an english entry needs to be present to be forwarded to the translations API.
        let entry = pokemonSpecies.flavorTextEntries.first {
            $0.language.name == "en"
        }
        
        guard let entry else {
            throw ShakespearemonRepositoryError.englishDescriptionNotFound
        }
        
        let shakespeareanTranslation = try await translationsDataSource.getShakespeareanTranslation(of: entry.cleanedFlavorText)
        
        return shakespeareanTranslation.contents.translated
    }
    
    func getPokemonSpriteURL(ofPokemon name: String) async throws -> URL {
        let pokemon = try await pokemonDataSource.getPokemon(of: name)
        
        let urlString = pokemon.sprites.frontDefault
        
        guard let url = URL(string: urlString) else {
            throw ShakespearemonRepositoryError.spriteUrlMalformed(string: urlString)
        }
        
        return url
    }
}
