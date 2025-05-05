//
//  ShakespearemonError.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 03/05/25.
//

import Foundation

/// An error interface on which all SDK errors conform to.
///
/// Use it to have detailed infos of the errors happening inside the SDK.
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
