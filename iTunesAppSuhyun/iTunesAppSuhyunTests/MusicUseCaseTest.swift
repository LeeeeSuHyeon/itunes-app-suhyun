//
//  MusicUseCaseTest.swift
//  iTunesAppSuhyunTests
//
//  Created by 이수현 on 5/10/25.
//

import XCTest
@testable import iTunesAppSuhyun

final class MusicUseCaseTest: XCTestCase {
    private var useCase: MusicUseCaseProtocol!

    override func setUp() {
        super.setUp()
        useCase = MusicUseCase(repository: MockRepository())
    }

    override func tearDown() {
        useCase = nil
        super.tearDown()
    }

    func test_fetchMusic() async throws {
        let resultWithAllParams = try await useCase.fetchMusic(keyword: "", country: "", limit: 0)
        XCTAssertEqual(resultWithAllParams.count, 1)

        let resultWithOnlyKeyword = try await useCase.fetchMusic(keyword: "")
        XCTAssertEqual(resultWithOnlyKeyword.count, 1)
    }
}
