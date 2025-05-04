//
//  HTTPServiceError.swift
//  shakespearemon-ios
//
//  Created by Fabrizio Scarano on 01/05/25.
//

import RealHTTP

enum HTTPServiceError: ShakespearemonError {
    case unexpectedEmptyData(expectedType: Decodable.Type)
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
