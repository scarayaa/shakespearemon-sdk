//
//  HTTPRequestMock.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

@testable import ShakespearemonSDK

struct HTTPRequestMock: HTTPRequestProtocol {
    
    private let responseMock: HTTPResponseMock
    
    init(responseMock: HTTPResponseMock) {
        self.responseMock = responseMock
    }
    
    func fetch() async throws -> any HTTPResponseProtocol {
        responseMock
    }
}
