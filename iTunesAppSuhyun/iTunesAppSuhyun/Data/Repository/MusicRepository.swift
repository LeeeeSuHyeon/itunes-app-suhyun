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

    func fetchMusic(keyword: String, country: String, limit: Int) async throws -> [Music] {
        do {
            let result: APIResponse<MusicDTO> = try await service.fetchData(
                    keyword: keyword,
                    country: country,
                    limit: limit,
                    media: ITunesMediaType.music.media
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

    private func transfrom(from results: [MusicDTO]) -> [Music] {
        let dateFormatter = ISO8601DateFormatter()
        return results.compactMap { (dto: MusicDTO) -> Music? in
            guard let releaseDate = dateFormatter.date(from: dto.releaseDate) else {
                return nil
            }

            return Music(
                musicId: dto.musicId,
                title: dto.title,
                artist: dto.artist,
                album: dto.album,
                imageURL: dto.imageURL,
                releaseDate: releaseDate,
                durationInSeconds: dto.durationInMillis / 1000
            )
        }
    }
}
