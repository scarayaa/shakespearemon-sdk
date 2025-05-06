//
//  HTTPMockOperation.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

@testable import ShakespearemonSDK

struct HTTPMockOperation<Result: Decodable>: HTTPOperation {
    
    typealias Result = Result
    
    let method: HTTPMethod = .get
    
    let path: String = "testPath"
    
    var queryParameters: [String : String] = ["test" : "parameter"]
    
    var httpService: any HTTPServiceProtocol
    
    private let responseMock: HTTPResponseMock
    
    init(httpService: any HTTPServiceProtocol, responseMock: HTTPResponseMock) {
        self.httpService = httpService
        self.responseMock = responseMock
    }
    
    func makeRequest() -> any HTTPRequestProtocol {
        HTTPRequestMock(responseMock: responseMock)
    }
}
