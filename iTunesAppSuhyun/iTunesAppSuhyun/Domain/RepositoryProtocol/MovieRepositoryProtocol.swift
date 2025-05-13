//
//  MovieRepositoryProtocol.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/13/25.
//

import Foundation

protocol MovieRepositoryProtocol {
    func fetchMovie(keyword: String, country: String, limit: Int) async throws -> [Movie]
}
