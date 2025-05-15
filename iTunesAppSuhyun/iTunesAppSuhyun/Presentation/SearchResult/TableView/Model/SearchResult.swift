//
//  SearchResult.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/13/25.
//

import Foundation

struct SearchResult {
    let mediaInfo: MediaInfo

    init(mediaInfo: MediaInfo) {
        self.mediaInfo = mediaInfo
    }
//    init(movie: Movie) {
//        self.id = movie.mediaInfo.id
//        self.title = movie.mediaInfo.title
//        self.releaseDate = movie.mediaInfo.releaseDate
//        self.genre = movie.mediaInfo.genre
//        self.imageURL = movie.mediaInfo.imageURL
//    }
//
//    init(podcast: Podcast) {
//        self.id = podcast.podcastId
//        self.title = podcast.title
//        self.releaseDate = podcast.releaseDate
//        self.genre = podcast.primaryGenre
//        self.imageURL = podcast.imageURL
//    }
}
