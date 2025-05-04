//
//  PokemonRepository.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import Foundation.NSURL

final class PokemonRepository: PokemonRepositoryProtocol {
    
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
        
        let entry = pokemonSpecies.flavorTextEntries.first {
            $0.language.name == "en"
        }
        
        guard let entry else {
            throw PokemonRepositoryError.englishDescriptionNotFound
        }
        
        let shakespereanTranslation = try await translationsDataSource.getShakespereanTranslation(of: entry.cleanedFlavorText)
        
        return shakespereanTranslation.contents.translated
    }
    
    func getPokemonSpriteURL(ofPokemon name: String) async throws -> URL {
        let pokemon = try await pokemonDataSource.getPokemon(of: name)
        
        let urlString = pokemon.sprites.frontDefault
        
        guard let url = URL(string: urlString) else {
            throw PokemonRepositoryError.spriteUrlMalformed(string: urlString)
        }
        
        return url
    }
}
