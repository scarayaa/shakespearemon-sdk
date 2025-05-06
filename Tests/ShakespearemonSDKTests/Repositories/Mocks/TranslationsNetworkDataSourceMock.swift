//
//  TranslationsNetworkDataSourceMock.swift
//  shakespearemon-sdk
//
//  Created by Fabrizio Scarano on 06/05/25.
//

@testable import ShakespearemonSDK

struct TranslationsNetworkDataSourceMock: TranslationsNetworkDataSourceProtocol {
    
    private let testcase: RepositoryTestCase
    
    init(testcase: RepositoryTestCase) {
        self.testcase = testcase
    }
    
    func getShakespeareanTranslation(of text: String) async throws -> Translation {
        switch testcase {
        case .pokemonshakespeareanDescription(let languageCode) where languageCode == "en":
            mockShakespeareanTranslation()
        default:
            fatalError("Unhandled test case.")
        }
    }
    
    private func mockShakespeareanTranslation() -> Translation {
        Translation(
            contents: Translation.Contents(
                translated: "Thee did giveth mr. Tim a hearty meal,  but unfortunately what he did doth englut did maketh him kicketh the bucket."
            )
        )
    }
}
