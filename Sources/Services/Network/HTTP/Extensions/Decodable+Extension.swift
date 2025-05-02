//
//  Decodable+Extension.swift
//  shakespearemon-ios
//
//  Created by Fabrizio Scarano on 01/05/25.
//

import Foundation

extension Decodable {
    
    static func decode(_ data: Data) throws -> Self {
        try JSONDecoder().decode(self, from: data)
    }
}
