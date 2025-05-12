//
//  NetworkManagerTest.swift
//  iTunesAppSuhyunTests
//
//  Created by 이수현 on 5/10/25.
//

import XCTest
@testable import iTunesAppSuhyun

final class NetworkManagerTest: XCTestCase {
    private let url = URL(string: "https://example.com")!
    private var mockSession: MockSession!

    override func setUp() {
        super.setUp()
        self.mockSession = MockSession()
    }

    override func tearDown() {
        mockSession = nil
        super.tearDown()
    }


    func test_invalidResponse_error() {
        let expectation = XCTestExpectation(description: "Expect invalid response error")
        mockSession.mockData = Data()
        mockSession.mockResponse = URLResponse(
            url: url,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )

        let manager = NetworkManager(session: mockSession)
        var result: Error?

        Task {
            do {
                let _: APIResponse<MusicDTO> = try await manager.fetchData(url: url)
                XCTFail("❌ NetworkError.invalidResponse를 예상했지만 성공함")
            } catch {
                if case NetworkError.invalidResponse = error {
                    result = error
                    expectation.fulfill()
                } else {
                    XCTFail("❌ NetworkError.invalidResponse를 예상했지만 다른 에러 발생: \(error.localizedDescription)")
                }
            }
        }

        wait(for: [expectation], timeout: 2.0)
        XCTAssertNotNil(result)
    }

    func test_server_Error() {
        let expectation = XCTestExpectation(description: "Expect Server Error")
        let statusCode = 404
        mockSession.mockData = Data()
        mockSession.mockResponse = HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )

        let manager = NetworkManager(session: mockSession)
        var result: Error?

        Task {
            do {
                let _: APIResponse<MusicDTO> = try await manager.fetchData(url: url)
                XCTFail("❌ NetworkError.serverError(404)를 예상했지만 성공함")
            } catch {
                if case NetworkError.serverError(let code) = error, code == statusCode {
                    result = error
                    expectation.fulfill()
                } else {
                    XCTFail("❌ NetworkError.serverError(404)를 예상했지만 다른 에러 발생")
                }
            }
        }

        wait(for: [expectation], timeout: 2.0)
        XCTAssertNotNil(result)
    }

    func test_decoding_error() {
        let mockData = mockJsonData.data(using: .utf8)
        let expectation = XCTestExpectation(description: "Expect Decoding Error")

        mockSession.mockData = mockData
        mockSession.mockResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields:  ["Content-Type": "application/json"])

        let manager = NetworkManager(session: mockSession)
        var result: Error?

        Task {
            do {
                let _: APIResponse<MockMusicDTO> = try await manager.fetchData(url: url)
                XCTFail("❌ NetworkError.decodingError를 예상했지만 성공함")
            } catch {
                if case NetworkError.decodingError = error {
                    result = error
                    expectation.fulfill()
                } else {
                    XCTFail("❌ NetworkError.decodingError를 예상했지만 다른 에러 발생")
                }
            }
        }

        wait(for: [expectation], timeout: 2.0)
        XCTAssertNotNil(result)
    }

    func test_network_error() {
        let expectation = XCTestExpectation(description: "Expect Network Error")
        let manager = NetworkManager(session: mockSession)
        var result: Error?

        // data, response 없이 fetchData
        Task {
            do {
                let _: APIResponse<MockMusicDTO> = try await manager.fetchData(url: url)
                XCTFail("❌ NetworkError.NetworkError를 예상했지만 성공함")
            } catch {
                if case NetworkError.networkFailure = error {
                    result = error
                    expectation.fulfill()
                } else {
                    XCTFail("❌ NetworkError.NetworkError를 예상했지만 다른 에러 발생")
                }
            }
        }

        wait(for: [expectation], timeout: 2)
        XCTAssertNotNil(result)
    }
}


