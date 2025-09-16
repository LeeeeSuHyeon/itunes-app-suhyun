//
//  MusicRepositoryTest.swift
//  iTunesAppSuhyunTests
//
//  Created by 이수현 on 5/10/25.
//

import XCTest
@testable import iTunesAppSuhyun

final class MusicRepositoryTest: XCTestCase {
    private var repository: MusicRepository!

    override func setUp() {
        super.setUp()
        let service = MockItunesNetwork()
        repository = MusicRepository(service: service)
    }

    override func tearDown() {
        repository = nil
        super.tearDown()
    }

    func test_fetchMusic() async throws {
        let result = try await repository.fetchMusic(keyword: "", country: "", limit: 0)
        XCTAssertEqual(result.count, 1)
    }
}
