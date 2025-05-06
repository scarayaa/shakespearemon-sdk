//
//  TranslationsNetworkDataSourceProtocol.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

/// A data source interface used to define required methods
/// to translate texts.
protocol TranslationsNetworkDataSourceProtocol {
    
    /// Fetches the shakespeare translation of the given text.
    ///
    /// - Parameters:
    ///     - text: The text to translate.
    /// - Returns:
    ///     A structure containing the translated version of the text.
    func getShakespeareanTranslation(of text: String) async throws -> Translation
}
