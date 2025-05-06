//
//  HTTPServiceProtocol.swift
//  shakespearemon-ios
//
//  Created by Fabrizio Scarano on 01/05/25.
//

/// A simple HTTP protocol that defines a wrapper to make GET and POST requests with some query parameters.
protocol HTTPServiceProtocol {
    
    /// The base path used by the wrapper.
    var basePath: String { get }
    
    /// A simple fetch operation, in which a method, a path and some query
    /// parameters may be specified (only things needed for this project).
    ///
    /// - Parameters:
    ///     - operation: The HTTPOperation to execute.
    /// - Returns:
    ///     a generic `Result` type expected from the HTTP call.
    func fetch<Result: Decodable>(using request: any HTTPRequestProtocol) async throws -> Result
}
