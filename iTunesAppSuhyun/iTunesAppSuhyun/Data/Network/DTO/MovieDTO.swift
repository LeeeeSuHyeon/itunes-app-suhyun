//
//  MovieDTO.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/12/25.
//

import Foundation

struct MovieDTO: Decodable {
    let movieId: Int
    let title: String
    let artist: String
    let imageURL: String
    let price: Double
    let genre: String
    let contentAdvisoryRating: String
    let description: String
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case movieId = "trackId"
        case title = "trackName"
        case artist = "artistName"
        case imageURL = "artworkUrl100"
        case price = "trackPrice"
        case genre = "primaryGenreName"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case description = "longDescription"
        case releaseDate
    }
}
