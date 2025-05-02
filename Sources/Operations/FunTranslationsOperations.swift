//
//  FunTranslations.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

enum FunTranslationsOperations {
    
    struct GetShakespereanTranslation: HTTPOperation {
        
        typealias Result = Translation
        
        let method: HTTPMethod = .post

        let path: String = "translate/shakespeare.json"
        
        let parameters: [String : Any]
        
        let httpService: any HTTPServiceProtocol
        
        init(httpService: any HTTPServiceProtocol, text: String) {
            self.httpService = httpService
            parameters = ["text" : text]
        }
    }
}
