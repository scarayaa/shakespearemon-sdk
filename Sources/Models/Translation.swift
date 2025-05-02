//
//  Translation.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

struct Translation: Decodable {
    let success: Success
    let contents: Contents
}

extension Translation {
    
    struct Success: Decodable {
        let total: Int
    }
    
    struct Contents: Decodable {
        let translated: String
        let text: String
        let translation: String
    }
}
