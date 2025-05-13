//
//  Podcast.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/13/25.
//

import Foundation

struct PodcastDTO: Decodable {
    let podcastId: Int
    let title: String
    let artist: String
    let imageURL: String
    let primaryGenre: String
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case podcastId = "trackId"
        case title = "trackName"
        case artist = "artistName"
        case imageURL = "artworkUrl600"
        case primaryGenre = "primaryGenreName"
        case releaseDate
    }
}
