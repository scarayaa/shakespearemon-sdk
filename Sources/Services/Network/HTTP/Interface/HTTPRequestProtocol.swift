//
//  HTTPRequestProtocol.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

protocol HTTPRequestProtocol {
    func fetch() async throws -> any HTTPResponseProtocol
}
