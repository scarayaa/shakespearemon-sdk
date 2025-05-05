//
//  HTTPService.swift
//  shakespearemon-ios
//
//  Created by Fabrizio Scarano on 01/05/25.
//

import Foundation.NSCoder
import RealHTTP

/// A simple HTTP wrapper to make GET and POST requests with some query parameters.
final class HTTPService: HTTPServiceProtocol {
    
    /// The base path used by this service.
    let basePath: String
    
    /// The underlying HTTP client, based on URLSession.
    private let client: HTTPClient = .shared
    
    init(basePath: String) {
        self.basePath = basePath
    }
    
    /// A simple fetch method, in which a method, a path and some query
    /// parameters may be specified (only thing needed for this project).
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
            // Handling most common errors in the 4xx range for the project, like
            // 404 and 429
            if error.statusCode.responseType == .clientError {
                throw HTTPServiceError.clientError(error.statusCode)
            } else {
                throw error
            }
        }
        
        guard let data = response.data else {
            // Handling the case `Result` is of type `Void`
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
