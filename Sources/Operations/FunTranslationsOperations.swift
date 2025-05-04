//
//  FunTranslations.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import Foundation.NSURL

enum FunTranslationsOperations {
    
    struct GetShakespereanTranslation: HTTPOperation {
        
        typealias Result = Translation
        
        let method: HTTPMethod = .get

        let path: String = "shakespeare.json"
        
        let queryParameters: [String : String]
        
        let httpService: any HTTPServiceProtocol
        
        init(httpService: any HTTPServiceProtocol, text: String) {
            self.httpService = httpService
            queryParameters = ["text" : text]
        }
    }
}
