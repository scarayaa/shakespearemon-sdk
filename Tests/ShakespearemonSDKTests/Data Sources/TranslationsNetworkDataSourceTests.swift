//
//  TranslationsNetworkDataSourceTests.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

import XCTest
@testable import ShakespearemonSDK

final class TranslationsNetworkDataSourceTests: XCTestCase {
    
    /// Tests the correct retrieval of a Translation structure in a success environment.
    func testGetshakespeareanTranslation() async throws {
        let mockedTranslation = mockShakespeareanTranslation()
        let mockHttpService = HTTPServiceMock(testCase: .shakespeareanTranslation(mockedTranslation))
        let sut = TranslationsNetworkDataSource(httpService: mockHttpService)
        
        // Name can be anything in the 3-12 length range. Mock is returning always the same response. This
        // only tests the correct get of the Pokemon structure given a success response.
        let inputText = "You gave Mr. Tim a hearty meal, but unfortunately what he ate made him die."
        let translation = try await sut.getShakespeareanTranslation(of: inputText)
        
        let expectedText = "Thee did giveth mr. Tim a hearty meal,  but unfortunately what he did doth englut did maketh him kicketh the bucket."
        XCTAssertEqual(translation.contents.translated, expectedText)
    }
    
    private func mockShakespeareanTranslation() -> Translation {
        Translation(
            contents: Translation.Contents(
                translated: "Thee did giveth mr. Tim a hearty meal,  but unfortunately what he did doth englut did maketh him kicketh the bucket."
            )
        )
    }
}
