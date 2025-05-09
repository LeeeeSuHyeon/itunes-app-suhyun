//
//  Music.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import Foundation

struct Music: Hashable {
    let musicId: Int
    let title: String
    let artist: String
    let imageURL: String
    let releaseDate: Date
    let durationInSeconds: Int
}
