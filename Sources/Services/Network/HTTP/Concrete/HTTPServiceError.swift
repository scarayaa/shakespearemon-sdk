//
//  HTTPServiceError.swift
//  shakespearemon-ios
//
//  Created by Fabrizio Scarano on 01/05/25.
//

import RealHTTP

/// Represents a list of HTTP service errors.
enum HTTPServiceError: ShakespearemonError {
    /// The system expected some data, but its content was empty.
    case unexpectedEmptyData(expectedType: Decodable.Type)
    /// A 4xx client error.
    case clientError(HTTPStatusCode)
    
    var errorDescription: String? {
        switch self {
        case .clientError(let statusCode) where statusCode == .notFound:
            "Resource not found."
        case .clientError(let statusCode) where statusCode == .tooManyRequests:
            "Too many requests. Try later."
        default:
            genericDescription
        }
    }
    
    var description: String {
        switch self {
        case .clientError(let statusCode):
            "Client Error: status code \(statusCode.rawValue)"
        case .unexpectedEmptyData(let type):
            "Expected \(type) but found empty data"
        }
    }
}
