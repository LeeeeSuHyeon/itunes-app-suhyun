//
//  PodcastUseCase.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/13/25.
//

import Foundation

protocol PodcastUseCaseProtocol {
    func fetchPodcast(keyword: String, country: String, limit: Int) async throws -> [Podcast]
}

extension PodcastUseCaseProtocol {
    func fetchPodcast(
        keyword: String,
        country: String = "kr",
        limit: Int = 10
    ) async throws -> [Podcast] {
        try await fetchPodcast(keyword: keyword, country: country, limit: limit)
    }
}

final class PodcastUseCase: PodcastUseCaseProtocol {
    private let repository: PodcastRepositoryProtocol

    init(repository: PodcastRepositoryProtocol) {
        self.repository = repository
    }

    func fetchPodcast(
        keyword: String,
        country: String = "kr",
        limit: Int = 10
    ) async throws -> [Podcast] {
        try await repository.fetchPodcast(keyword: keyword, country: country, limit: limit)
    }
}
