//
//  MusicUseCase.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/9/25.
//

import Foundation

protocol MusicUseCaseProtocol {
    func fetchMusic(
        keyword: String,
        country: String,
        limit: Int
    ) async throws -> [Music]
}

extension MusicUseCaseProtocol {
    func fetchMusic(
        keyword: String,
        country: String = "kr",
        limit: Int = 10
    ) async throws -> [Music] {
        try await fetchMusic(
            keyword: keyword,
            country: country,
            limit: limit
        )
    }
}

final class MusicUseCase: MusicUseCaseProtocol {
    private let repository: MusicRepositoryProtocol

    init(repository: MusicRepositoryProtocol) {
        self.repository = repository
    }

    func fetchMusic(
        keyword: String,
        country: String = "kr",
        limit: Int = 10
    ) async throws -> [Music] {
        try await repository.fetchMusic(
            keyword: keyword,
            country: country,
            limit: limit
        )
    }
}
