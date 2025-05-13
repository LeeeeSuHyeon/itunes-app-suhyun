//
//  SearchType.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/12/25.
//

import Foundation

enum SearchType: Int, CaseIterable {
    case movie
    case podcast

    var title: String {
        switch self {
        case .movie: return "영화"
        case .podcast: return "팟캐스트"
        }
    }
}
