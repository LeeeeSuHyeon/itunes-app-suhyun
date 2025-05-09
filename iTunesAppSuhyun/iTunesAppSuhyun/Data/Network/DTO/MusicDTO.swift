//
//  MusicDTO.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import Foundation

struct MusicDTO: Decodable {
    let musicId: Int
    let artist: String
    let title: String
    let imageURL: String
    let releaseDate: String
    let durationInMillis: Int

    enum CodingKeys: String, CodingKey {
        case musicId = "trackId"
        case artist = "artistName"
        case title = "trackName"
        case imageURL = "artworkUrl100"
        case releaseDate
        case durationInMillis = "trackTimeMillis"
    }
}

extension MusicDTO {
    func toMusic() -> Music {
        let dateFormatter = DateFormatter()
        let date = dateFormatter.date(from: releaseDate) ?? Date() // MappingError

        return Music(
            musicId: musicId,
            title: title,
            artist: artist,
            imageURL: imageURL,
            releaseDate: date,
            durationInSeconds: durationInMillis / 1000
        )
    }
}
