//
//  APIResponse.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let resultCount: Int
    let results: [T]
}
