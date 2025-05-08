//
//  ITunesNewtork.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import Foundation

final class ITunesNewtork {
    private let baseURL = "https://itunes.apple.com/search"
    private let manager: NetworkManagerProtocol

    init(manager: NetworkManagerProtocol) {
        self.manager = manager
    }

    func fetchMusicData(
        keyword: String,
        country: String = "kr",
        limit: Int = 25,
        language: String = "ko_KR",
        media: String = "music"
    ) async throws -> APIResponse<MusicDTO> {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "term", value: keyword),
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "lang", value: language),
            URLQueryItem(name: "media", value: media),
        ]

        guard let url = components?.url else {
            throw NetworkError.invalidURL("\(baseURL) - music")
        }

        return try await manager.fetchData(url: url)
    }
}
