//
//  URLSessionProtocol.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
