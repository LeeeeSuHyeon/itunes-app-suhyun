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
            .map { transform(from: $0) }
    }

    private func transform(from dto: MusicDTO) -> Music {
        let dateFormatter = DateFormatter()
        let date = dateFormatter.date(from: dto.releaseDate) ?? Date() //TODO: MappingError

        return Music(
            musicId: dto.musicId,
            title: dto.title,
            artist: dto.artist,
            album: dto.album,
            imageURL: dto.imageURL,
            releaseDate: date,
            durationInSeconds: dto.durationInMillis / 1000
        )
    }
}
