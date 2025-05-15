//
//  MovieRepository.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/13/25.
//

import Foundation

final class MovieRepository: MovieRepositoryProtocol {
    private let service: ITunesNetworkProtocol

    init(service: ITunesNetworkProtocol) {
        self.service = service
    }

    func fetchMovie(keyword: String, country: String, limit: Int) async throws -> [Movie] {
        do {
            let result: APIResponse<MovieDTO> = try await service.fetchData(
                keyword: keyword,
                country: country,
                limit: limit,
                media: ITunesMediaType.movie.media
            )
            return transfrom(from: result.results)
        } catch {
            if let error = error as? NetworkError {
                throw AppError.networkError(error)
            } else {
                throw AppError.unKnown(error)
            }
        }
    }

    private func transfrom(from results: [MovieDTO]) -> [Movie] {
        let dateFormatter = ISO8601DateFormatter()
        return results.compactMap { (dto: MovieDTO) -> Movie? in
            guard let releaseDate = dateFormatter.date(from: dto.releaseDate) else {
                return nil
            }

            return Movie(
                movieId: dto.movieId,
                title: dto.title,
                director: dto.director,
                posterURL: dto.posterURL,
                price: dto.price,
                genre: dto.genre,
                contentAdvisoryRating: dto.contentAdvisoryRating,
                description: dto.description,
                releaseDate: releaseDate
            )
        }
    }
}
