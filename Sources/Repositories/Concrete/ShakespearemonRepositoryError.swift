//
//  ShakespearemonRepositoryError.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import Foundation.NSError

/// Represents a list of common errors that may be thrown by the repository.
enum ShakespearemonRepositoryError: ShakespearemonError {
    /// Data was retrieved successfully, but no english translation was found.
    case englishDescriptionNotFound
    /// Pokémon sprite's URL was retrieved correctly, but it is malformed.
    case spriteUrlMalformed(string: String)
    
    var errorDescription: String? {
        switch self {
        case .englishDescriptionNotFound:
            "Some data are missing."
        case .spriteUrlMalformed:
            genericDescription
        }
    }
    
    var description: String {
        switch self {
        case .englishDescriptionNotFound:
            "PokeAPI didn't return an english description for the given name."
        case .spriteUrlMalformed(let string):
            "The returned sprite URL (\(string)) was malformed."
        }
    }
}
