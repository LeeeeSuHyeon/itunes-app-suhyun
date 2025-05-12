//
//  MusicRepositoryProtocol.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/9/25.
//

import Foundation

protocol MusicRepositoryProtocol {
    func fetchMusic(
        keyword: String,
        country: String,
        limit: Int
    ) async throws -> [Music]
}
