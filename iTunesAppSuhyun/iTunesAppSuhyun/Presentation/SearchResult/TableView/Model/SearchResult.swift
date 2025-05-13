//
//  SearchResult.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/13/25.
//

import Foundation

struct SearchResult {
    let id: Int
    let title: String
    let releaseDate: Date
    let genre: String
    let imageURL: String

    init(movie: Movie) {
        self.id = movie.movieId
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.genre = movie.genre
        self.imageURL = movie.posterURL
    }

    init(podcast: Podcast) {
        self.id = podcast.podcastId
        self.title = podcast.title
        self.releaseDate = podcast.releaseDate
        self.genre = podcast.primaryGenre
        self.imageURL = podcast.imageURL
    }
}
