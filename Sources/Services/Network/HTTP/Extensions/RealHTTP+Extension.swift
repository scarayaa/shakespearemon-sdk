//
//  RealHTTP+Extension.swift
//  shakespearemon-ios
//
//  Created by Fabrizio Scarano on 01/05/25.
//

// Importing RealHTTP only doesn't work because `RealHTTP` contains an enum also called `RealHTTP`.
// This won't allow to correctly extend `HTTPMethod` which name is used in both RealHTTP and this SDK.
import struct RealHTTP.HTTPMethod
import class RealHTTP.HTTPRequest
import class RealHTTP.HTTPResponse

extension RealHTTP.HTTPMethod {
    
    init(from method: HTTPMethod) {
        switch method {
        case .get:
            self = .get
        case .post:
            self = .post
        }
    }
}

extension HTTPRequest: HTTPRequestProtocol {
    func fetch() async throws -> any HTTPResponseProtocol {
        try await fetch(.shared)
    }
}

extension HTTPResponse: HTTPResponseProtocol {}
