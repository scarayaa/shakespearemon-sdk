//
//  ShakespearemonSDKTests.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

import Foundation

final class ShakespearemonSDKTests {
    
    static func loadJson<T: Decodable>(filename fileName: String) -> T? {
        let bundle = Bundle.module
        
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("loadJson error: \(error)")
            return nil
        }
    }
}
