//
//  PokemonRepositoryError.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

import Foundation.NSError

enum PokemonRepositoryError: ShakespearemonError {
    case englishDescriptionNotFound
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
