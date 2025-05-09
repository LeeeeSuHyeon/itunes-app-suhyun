//
//  ITunesNewtork.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import Foundation

protocol ITunesNetworkProtocol {
    func fetchMusic(
        keyword: String,
        country: String,
        limit: Int
    ) async throws -> APIResponse<MusicDTO>
}

final class ITunesNewtork: ITunesNetworkProtocol {
    private let baseURL = "https://itunes.apple.com/search"
    private let manager: NetworkManagerProtocol

    init(manager: NetworkManagerProtocol) {
        self.manager = manager
    }

    func fetchMusic(
        keyword: String,
        country: String,
        limit: Int = 10
    ) async throws -> APIResponse<MusicDTO> {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "term", value: keyword),
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "lang", value: "ko_KR"),
            URLQueryItem(name: "media", value: "music"),
        ]

        guard let url = components?.url else {
            throw NetworkError.invalidURL("\(baseURL) - music")
        }

        return try await manager.fetchData(url: url)
    }
}
