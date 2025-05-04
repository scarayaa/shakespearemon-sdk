//
//  ShakespearemonError.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 03/05/25.
//

import Foundation

public protocol ShakespearemonError: LocalizedError, CustomStringConvertible {}

extension ShakespearemonError {
    
    var genericDescription: String {
        "An internal error has occured."
    }
    
    var errorDescription: String? {
        genericDescription
    }
    
    var description: String {
        localizedDescription
    }
}
