//
//  Translation.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

struct Translation: Decodable {
    let contents: Contents
    
    init(contents: Contents) {
        self.contents = contents
    }
}

extension Translation {
    
    struct Contents: Decodable {
        let translated: String
        
        init(translated: String) {
            self.translated = translated
        }
    }
}
