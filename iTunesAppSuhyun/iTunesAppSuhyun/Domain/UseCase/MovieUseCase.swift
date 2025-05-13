//
//  MovieUseCase.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/13/25.
//

import Foundation

protocol MovieUseCaseProtocol {
    func fetchMovie(keyword: String, country: String, limit: Int) async throws -> [Movie]
}
extension MovieUseCaseProtocol {
    func fetchMovie(keyword: String, country: String = "kr", limit: Int = 10) async throws -> [Movie] {
        try await fetchMovie(keyword: keyword, country: country, limit: limit)
    }
}

final class MovieUseCase: MovieUseCaseProtocol {
    private let repository: MovieRepositoryProtocol

    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }

    func fetchMovie(keyword: String, country: String, limit: Int) async throws -> [Movie] {
        try await repository.fetchMovie(keyword: keyword, country: country, limit: limit)
    }
}
