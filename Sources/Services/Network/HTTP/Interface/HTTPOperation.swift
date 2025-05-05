//
//  HTTPOperation.swift
//  shakespearemon-ios
//
//  Created by Fabrizio Scarano on 01/05/25.
//

/// Represents a generic HTTP DTO for handling a specific HTTP request.
protocol HTTPOperation: NetworkOperation where Result: Decodable {
    
    var method: HTTPMethod { get }
    
    var path: String { get }
    
    var queryParameters: [String : String] { get }
    
    var httpService: any HTTPServiceProtocol { get }
}

extension HTTPOperation {
    
    func run() async throws -> Result {
        try await httpService.fetch(method: method, path: path, queryParameters: queryParameters)
    }
}
