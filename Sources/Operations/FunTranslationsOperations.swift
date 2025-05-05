//
//  FunTranslations.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import Foundation.NSURL

enum FunTranslationsOperations {
    
    /// The HTTP DTO for performing the Shakespearean translation.
    struct getShakespeareanTranslation: HTTPOperation {
        
        typealias Result = Translation
        
        // Even if FunTranslations API specifies a POST method, GET is the only one working.
        // I didn't investigate further since it works correctly with GET.
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
