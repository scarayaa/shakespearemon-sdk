//
//  HTTPMethod+Extension.swift
//  shakespearemon-ios
//
//  Created by Fabrizio Scarano on 01/05/25.
//

import struct RealHTTP.HTTPMethod

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
