//
//  ExtraInfo.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/16/25.
//

import Foundation

protocol ExtraInfoProtocol {}

struct MovieExtraInfo: ExtraInfoProtocol {
    var price: Double
    var description: String
    var previewURL: String
    var thumbnailImageURL: String
}
