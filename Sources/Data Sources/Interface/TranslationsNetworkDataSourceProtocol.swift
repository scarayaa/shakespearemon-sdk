//
//  TranslationsNetworkDataSourceProtocol.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

protocol TranslationsNetworkDataSourceProtocol {
    
    func getShakespereanTranslation(of text: String) async throws -> Translation
}
