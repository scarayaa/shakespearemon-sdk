//
//  TranslationsNetworkDataSource.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

final class TranslationsNetworkDataSource: TranslationsNetworkDataSourceProtocol {
    
    private let httpService: any HTTPServiceProtocol
    
    init(httpService: any HTTPServiceProtocol) {
        self.httpService = httpService
    }
    
    func getShakespereanTranslation(of text: String) async throws -> Translation {
        try await FunTranslationsOperations.GetShakespereanTranslation(
            httpService: httpService,
            text: text
        ).run()
    }
}
