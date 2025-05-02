//
//  HTTPService.swift
//  shakespearemon-ios
//
//  Created by Fabrizio Scarano on 01/05/25.
//

import Foundation
import RealHTTP

final class HTTPService: HTTPServiceProtocol {
    
    let basePath: String
    
    private let client: HTTPClient = .shared
    
    init(basePath: String) {
        self.basePath = basePath
    }
    
    func fetch<Result: Decodable>(method: HTTPMethod, path: String, parameters: [String : Any]) async throws -> Result {
        let request = HTTPRequest {
            $0.method = .init(from: method)
            $0.path = "\(basePath)/\(path)"
            $0.add(parameters: parameters)
        }
        
        let response = try await request.fetch(client)
        
        if let error = response.error {
            throw error
        }
        
        guard let data = response.data else {
            if let result = () as? Result {
                return result
            } else {
                throw HTTPServiceError.unexpectedEmptyData
            }
        }
        
        let result = try Result.decode(data)
        return result
    }
}
