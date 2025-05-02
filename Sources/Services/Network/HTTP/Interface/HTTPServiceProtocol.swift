//
//  HTTPServiceProtocol.swift
//  shakespearemon-ios
//
//  Created by Fabrizio Scarano on 01/05/25.
//

import Foundation

protocol HTTPServiceProtocol {
    
    var basePath: String { get }
    
    func fetch<Result: Decodable>(method: HTTPMethod, path: String, parameters: [String : Any]) async throws -> Result
}
