//
//  AppError.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import Foundation

protocol AppErrorProtocol: LocalizedError {
    var errorDescription: String? { get }
    var debugDescription: String { get }
}

enum AppError: AppErrorProtocol {
    case NetworkError(NetworkError)
    case unKnown(Error)

    init(_ error: Error) {
        switch error {
        case let error as NetworkError:
            self = .NetworkError(error)
        default:
            self = .unKnown(error)
        }
    }

    var errorDescription: String? {
        switch self {
        case .NetworkError(let networkError):
            networkError.errorDescription
        case .unKnown:
            "알 수 없는 오류가 발생했습니다"
        }
    }

    var debugDescription: String {
        switch self {
        case .NetworkError(let networkError):
            networkError.debugDescription
        case .unKnown(let error):
            "알 수 없는 에러 발생: \(error.localizedDescription)"
        }
    }
}
