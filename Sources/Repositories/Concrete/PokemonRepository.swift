//
//  PokemonRepository.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

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
        
        let shakespereanTranslation = try await translationsDataSource.getShakespereanTranslation(of: entry.flavorText)
        
        return shakespereanTranslation.contents.translated
    }
    
    func getPokemonSpriteURL(ofPokemon name: String) async throws -> String {
        let pokemon = try await pokemonDataSource.getPokemon(of: name)
        return pokemon.sprites.frontDefault
    }
}
