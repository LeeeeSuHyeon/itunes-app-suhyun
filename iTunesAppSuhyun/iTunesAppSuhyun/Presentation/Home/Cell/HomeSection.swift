//
//  HomeSection.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import Foundation

enum HomeSection: Int, CaseIterable, Hashable {
    case Spring
    case Summer
    case Autumn
    case Winter

    var title: String {
        switch self {
        case .Spring:
            "봄 Best"
        case .Summer:
            "여름"
        case .Autumn:
            "가을"
        case .Winter:
            "겨울"
        }
    }

    var subTitle: String {
        switch self {
        case .Spring:
            "봄에 어울리는 음악 Top 10"
        case .Summer:
            "여름"
        case .Autumn:
            "가을"
        case .Winter:
            "겨울"
        }
    }
}

enum HomeItem: Hashable {
    case Spring(Music)
    case Summer(Music)
    case Autumn(Music)
    case Winter(Music)
}
