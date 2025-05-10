//
//  MockItunesNetwork.swift
//  iTunesAppSuhyunTests
//
//  Created by 이수현 on 5/10/25.
//

@testable import iTunesAppSuhyun
import Foundation

final class MockItunesNetwork: ITunesNetworkProtocol {
    func fetchMusic(keyword: String, country: String, limit: Int) async throws -> APIResponse<MusicDTO> {
      return mockData()
    }
}

extension MockItunesNetwork {
    func mockData() -> APIResponse<MusicDTO> {
        return APIResponse(
            resultCount: 1,
            results: [
                MusicDTO(
                    musicId: 0,
                    title: "mockTitle",
                    artist:  "mockArtist",
                    album:  "mockAlbum",
                    imageURL:  "mockImageURL",
                    releaseDate:  "mockReleaseDate",
                    durationInMillis: 0
                )
            ]
        )
    }
}
