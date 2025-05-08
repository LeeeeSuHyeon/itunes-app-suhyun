//
//  NetworkManager.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(url: URL) async throws -> APIResponse<T>
}

final class NetworkManager: NetworkManagerProtocol {
    private let session: URLSessionProtocol

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchData<T: Decodable>(url: URL) async throws -> APIResponse<T> {
        let urlRequest = URLRequest(url: url)
        print(url)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            guard (200..<300).contains(httpResponse.statusCode) else {
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }

            do {
                return try JSONDecoder().decode(APIResponse<T>.self, from: data)
            } catch {
                throw NetworkError.decodingError(error: error)
            }
        } catch {
            if let networkError = error as? NetworkError {
                throw networkError
            }
            
            throw NetworkError.networkFailure(error: error)
        }
    }
}
