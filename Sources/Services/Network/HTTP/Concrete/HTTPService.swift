//
//  HTTPService.swift
//  shakespearemon-ios
//
//  Created by Fabrizio Scarano on 01/05/25.
//

import Foundation.NSCoder
import RealHTTP

final class HTTPService: HTTPServiceProtocol {
    
    let basePath: String
    
    private let client: HTTPClient = .shared
    
    init(basePath: String) {
        self.basePath = basePath
    }
    
    func fetch<Result: Decodable>(
        method: HTTPMethod,
        path: String,
        queryParameters: [String : String]
    ) async throws -> Result {
        let request = HTTPRequest {
            $0.method = .init(from: method)
            $0.path = "\(basePath)/\(path)"
            $0.add(parameters: queryParameters)
        }
        
        print("▶️ Requesting -> \(request)")
        
        let response = try await request.fetch(client)
        
        print(response.error == nil ? "🟩 Success" : "🟥 Failure", "\(response) -> \(request)")
        
        if let error = response.error {
            if error.statusCode.responseType == .clientError {
                throw HTTPServiceError.clientError(error.statusCode)
            } else {
                throw error
            }
        }
        
        guard let data = response.data else {
            if let result = () as? Result {
                return result
            } else {
                throw HTTPServiceError.unexpectedEmptyData(expectedType: Result.self)
            }
        }
        
        let result = try Result.decode(data)
        return result
    }
}
