//
//  HTTPServiceTests.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

import XCTest
import RealHTTP
@testable import ShakespearemonSDK

final class HTTPServiceTests: XCTestCase {
    
    // No need to setUp or tearDown because it is stateless
    let sut = HTTPService(basePath: "testBasePath")
    
    /// Tests that HTTPService decodes the returned result correctly.
    func testSuccessWithExpectedResult() async throws {
        let operation = HTTPMockOperation<MockResult>(httpService: sut, responseMock: .successWithResult)
        let result = try await operation.run()
        
        XCTAssertEqual(result.string, "successWithResult")
    }
    
    /// Tests that HTTPService decodes correctly an empty response when expected
    func testSuccessWithEmptyResult() async throws {
        let operation = HTTPMockOperation<VoidResult>(httpService: sut, responseMock: .successWithEmptyData)
        // Nothing to check. If `run()` runs into problem will throw an error that'll be further thrown outside the scope
        // of this test making it failed.
        _ = try await operation.run()
    }
    
    func testErrorNotFound() async throws {
        let operation = HTTPMockOperation<MockResult>(httpService: sut, responseMock: .notFound)
        do {
            _ = try await operation.run()
            XCTFail("Expected an HTTPServiceError.clientError (notFound), but the operation succeded.")
        } catch let error as HTTPServiceError {
            switch error {
            case .unexpectedEmptyData:
                XCTFail("Expected `.clientError` but found `.unexpectedEmptyData`")
            case .clientError(let statusCode) where statusCode != .notFound:
                XCTFail("Expected `.clientError` with status code `.notFound`, but found \(statusCode.rawValue)")
            default:
                ()
            }
        }
    }
    
    func testErrorTooManyRequests() async throws {
        let operation = HTTPMockOperation<MockResult>(httpService: sut, responseMock: .tooManyRequests)
        do {
            _ = try await operation.run()
            XCTFail("Expected an HTTPServiceError.clientError (tooManyRequests), but the operation succeded.")
        } catch let error as HTTPServiceError {
            switch error {
            case .unexpectedEmptyData:
                XCTFail("Expected `.clientError` but found `.unexpectedEmptyData`")
            case .clientError(let statusCode) where statusCode != .tooManyRequests:
                XCTFail("Expected `.clientError` with status code `.tooManyRequests`, but found \(statusCode.rawValue)")
            default:
                ()
            }
        }
    }
    
    func testGenericNetworkError() async throws {
        let operation = HTTPMockOperation<MockResult>(httpService: sut, responseMock: .genericNetworkError)
        do {
            _ = try await operation.run()
            XCTFail("Expected an HTTPError, but the operation succeded.")
        } catch let error as HTTPError {
            // Just making sure that status code corresponds to the one specified in the mock.
            // The test is the same for any different status code from the ones specified.
            XCTAssertEqual(error.statusCode, .internalServerError)
        } catch {
            XCTFail("Expected an HTTPError but found error of type \(error.self)")
        }
    }
}
