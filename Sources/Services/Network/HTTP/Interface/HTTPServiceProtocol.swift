//
//  HTTPServiceProtocol.swift
//  shakespearemon-ios
//
//  Created by Fabrizio Scarano on 01/05/25.
//

protocol HTTPServiceProtocol {
    
    var basePath: String { get }
        
    func fetch<Result: Decodable>(
        method: HTTPMethod,
        path: String,
        queryParameters: [String : String]
    ) async throws -> Result
}
