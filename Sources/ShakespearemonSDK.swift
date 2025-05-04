//
//  Shakespearemon.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 02/05/25.
//

public struct ShakespearemonSDK {
    
    public static func getNewServiceInstance() -> ShakespearemonService {
        ShakespearemonAPI()
    }
}
