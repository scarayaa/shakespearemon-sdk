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
    
    init(basePath: String) {
        self.basePath = basePath
    }
    
    func fetch<Result: Decodable>(from operation: any HTTPOperation) async throws -> Result {
        let request = operation.makeRequest()
        
        print("▶️ Requesting -> \(request)")
        
        let response = try await request.fetch()
        
        print(response.error == nil ? "🟩 Success" : "🟥 Failure", "\(response) -> \(request)")
        
        return try getResult(from: response)
    }
    
    private func getResult<Result: Decodable>(from response: any HTTPResponseProtocol) throws -> Result {
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
