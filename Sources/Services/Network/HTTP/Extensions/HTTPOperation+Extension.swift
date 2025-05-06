//
//  HTTPOperation+Extension.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

import RealHTTP

extension HTTPOperation {
    func makeRequest() -> HTTPRequestProtocol {
        HTTPRequest {
            $0.method = .init(from: method)
            $0.path = "\(httpService.basePath)/\(path)"
            $0.add(parameters: queryParameters)
        }
    }
}
