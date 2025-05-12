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
    case networkError(AppErrorProtocol)
    case unKnown(Error)
}

extension AppError {
    var errorDescription: String? {
        switch self {
        case .networkError(let networkError):
            networkError.errorDescription
        case .unKnown:
            "알 수 없는 오류가 발생했습니다"
        }
    }

    var debugDescription: String {
        switch self {
        case .networkError(let networkError):
            networkError.debugDescription
        case .unKnown(let error):
            "알 수 없는 에러 발생: \(error.localizedDescription)"
        }
    }
}

extension AppError {
    enum AlertType {
        case networkError
        case defaultError

        var alertTitle: String {
            switch self {
            case .networkError:
                "네트워크 오류"
            case .defaultError:
                "오류"
            }
        }
    }

    var alertType: AlertType {
        switch self {
        case .networkError:
            return .networkError
        default:
            return .defaultError
        }
    }
}
