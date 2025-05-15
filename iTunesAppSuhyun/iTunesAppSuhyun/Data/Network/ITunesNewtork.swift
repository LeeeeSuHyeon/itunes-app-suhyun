//
//  ITunesNewtork.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import Foundation

protocol ITunesNetworkProtocol {
    func fetchData<T: Decodable>(
        keyword: String,
        country: String,
        limit: Int,
        media: String
    ) async throws -> APIResponse<T>
}

final class ITunesNewtork: ITunesNetworkProtocol {
    private let baseURL = "https://itunes.apple.com/search"
    private let manager: NetworkManagerProtocol

    init(manager: NetworkManagerProtocol) {
        self.manager = manager
    }

    func fetchData<T: Decodable>(
        keyword: String,
        country: String,
        limit: Int,
        media: String
    ) async throws -> APIResponse<T> {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "term", value: keyword),
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "lang", value: "ko_KR"),
            URLQueryItem(name: "media", value: media),
        ]

        guard let url = components?.url else {
            throw NetworkError.invalidURL("\(baseURL) - \(media)")
        }

        return try await manager.fetchData(url: url)
    }
}
