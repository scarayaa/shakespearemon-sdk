//
//  Shakespearemon.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

/// The entry point of the SDK.
public struct ShakespearemonSDK {
    
    /// PokeAPI base URL for retrieving pokèmon data.
    private static let BASE_PATH_POKEAPI = "https://pokeapi.co/api/v2"
    
    /// FunTranslations base URL for translating texts.
    private static let BASE_PATH_FUNTRANSLATIONS = "https://api.funtranslations.com/translate"
    
    // MARK: - Public
    
    /// Returns a new instance of the underlying service.
    public static func getNewServiceInstance() -> ShakespearemonService {
        // Just a simple factory method to hide the actual API implementation.
        ShakespearemonAPI(
            shakespearemonRepository: getNewRepository()
        )
    }
    
    // MARK: - Private
    
    private static func getNewRepository() -> ShakespearemonRepositoryProtocol {
        return ShakespearemonRepository(
            pokemonDataSource: getNewPokemonDataSource(),
            translationsDataSource: getNewTranslationsDataSource()
        )
    }
    
    private static func getNewPokemonDataSource() -> PokemonNetworkDataSourceProtocol {
        return PokemonNetworkDataSource(
            httpService: getNewHTTPService(
                basePath: BASE_PATH_POKEAPI
            )
        )
    }
    
    private static func getNewTranslationsDataSource() -> TranslationsNetworkDataSourceProtocol {
        TranslationsNetworkDataSource(
            httpService: getNewHTTPService(
                basePath: BASE_PATH_FUNTRANSLATIONS
            )
        )
    }
    
    private static func getNewHTTPService(basePath: String) -> HTTPServiceProtocol {
        HTTPService(basePath: basePath)
    }
}
