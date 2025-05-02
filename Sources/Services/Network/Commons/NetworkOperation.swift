//
//  NetworkOperation.swift
//  shakespearemon-ios
//
//  Created by Fabrizio Scarano on 01/05/25.
//

protocol NetworkOperation {
    
    associatedtype Result
    
    func run() async throws -> Result
}
