//
//  PodcastRepository.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/13/25.
//

import Foundation

final class PodcastRepository: PodcastRepositoryProtocol {
    private let service: ITunesNetworkProtocol

    init(service: ITunesNetworkProtocol) {
        self.service = service
    }

    func fetchPodcast(keyword: String, country: String, limit: Int) async throws -> [Podcast] {
        do {
            let result: APIResponse<PodcastDTO> = try await service.fetchData(
                keyword: keyword,
                country: country,
                limit: limit,
                media: ITunesMediaType.podcast.media
            )
            return transform(from: result.results)
        } catch {
            if let error = error as? NetworkError {
                throw AppError.networkError(error)
            } else {
                throw AppError.unKnown(error)
            }
        }
    }

    private func transform(from results: [PodcastDTO]) -> [Podcast] {
        let dateFormatter = ISO8601DateFormatter()

        return results.compactMap { dto -> Podcast? in
            guard let releaseDate = dateFormatter.date(from: dto.releaseDate) else {
                return nil
            }

            return Podcast(
                podcastId: dto.podcastId,
                title: dto.title,
                artist: dto.artist,
                imageURL: dto.imageURL,
                primaryGenre: dto.primaryGenre,
                releaseDate: releaseDate
            )
        }
    }
}
