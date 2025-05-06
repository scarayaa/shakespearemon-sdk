//
//  HTTPResponseMock.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

import Foundation.NSData
import RealHTTP
@testable import ShakespearemonSDK

enum HTTPResponseMock: HTTPResponseProtocol {
    case successWithResult
    case successWithEmptyData
    case notFound
    case tooManyRequests
    case genericNetworkError
    
    var error: HTTPError? {
        switch self {
        case .successWithResult, .successWithEmptyData:
            nil
        case .notFound:
            HTTPError(.network, code: .notFound)
        case .tooManyRequests:
            HTTPError(.network, code: .tooManyRequests)
        case .genericNetworkError:
            // Using 500, but any other error not listed above is not mapped to an internal one
            HTTPError(.network, code: .internalServerError)
        }
    }
    
    var data: Data? {
        guard let encodedMock else { return nil }
        
        return try? JSONEncoder().encode(encodedMock)
    }
    
    private var encodedMock: Encodable? {
        switch self {
        case .successWithResult:
            MockResult(string: "successWithResult")
        default:
            nil
        }
    }
}
