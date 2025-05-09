//
//  MusicRepository.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/9/25.
//

import Foundation

final class MusicRepository: MusicRepositoryProtocol {

    private let service: ITunesNetworkProtocol

    init(service: ITunesNetworkProtocol) {
        self.service = service
    }

    func fetchMusic(
        keyword: String,
        country: String,
        limit: Int
    ) async throws -> [Music] {
        return try await service
            .fetchMusic(
                keyword: keyword,
                country: country,
                limit: limit
            )
            .results
            .map { $0.toMusic() }
    }
}
