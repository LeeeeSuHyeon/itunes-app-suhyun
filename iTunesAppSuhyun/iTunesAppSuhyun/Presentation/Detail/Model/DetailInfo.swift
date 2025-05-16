//
//  DetailInfo.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/15/25.
//

import Foundation

struct DetailInfo {
    let mediaInfo: MediaInfo
    let type: MediaType
    let subTitle: String
    let replayTime: String
    var extraInfo: ExtraInfoProtocol?

    init(_ music: Music) {
        self.mediaInfo = music.mediaInfo
        self.type = .music
        self.subTitle = music.album
        self.replayTime = music.mediaInfo.durationInSeconds.toReplayTime()
    }

    init(_ movie: Movie) {
        self.mediaInfo = movie.mediaInfo
        self.type = .movie
        self.subTitle = movie.contentAdvisoryRating
        self.replayTime = movie.mediaInfo.durationInSeconds.toReplayTime()
        self.extraInfo = MovieExtraInfo(
            price: movie.price,
            description: movie.description,
            previewURL: movie.previewURL,
            thumbnailImageURL: movie.mediaInfo.imageURL
        )
    }

    init(_ podcast: Podcast) {
        self.mediaInfo = podcast.mediaInfo
        self.type = .podcast
        self.subTitle = podcast.mediaInfo.artist
        self.replayTime = podcast.mediaInfo.durationInSeconds.toReplayTime()
    }
}
