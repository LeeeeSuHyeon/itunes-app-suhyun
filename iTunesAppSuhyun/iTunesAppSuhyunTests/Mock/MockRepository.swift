//
//  MockRepository.swift
//  iTunesAppSuhyunTests
//
//  Created by 이수현 on 5/10/25.
//

@testable import iTunesAppSuhyun
import Foundation

final class MockRepository: MusicRepositoryProtocol {
    func fetchMusic(keyword: String, country: String, limit: Int) async throws -> [Music] {
        return [
            Music(
                musicId: 0,
                title: "mockTitle",
                artist: "mockArtist",
                album: "mockAlbum",
                imageURL: "mockImageURL",
                releaseDate: Date(),
                durationInSeconds: 0
            )
        ]
    }
}
