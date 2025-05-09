//
//  HomeViewModel.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import RxSwift

protocol ViewModelProtocol {
    associatedtype Action
    associatedtype State

    var action: ((Action) -> Void)? { get }
    var state: State { get }
}

final class HomeViewModel: ViewModelProtocol {

    enum Action {
        case fetchMusic
    }

    struct State {
        var springMusic = BehaviorSubject<[Music]>(value: [])
        var error = PublishSubject<AppError>()
    }

    var action: ((Action) -> Void)?
    var state = State()

    init() {
        action = {[weak self] action in
            guard let self else { return }
            switch action {
            case .fetchMusic:
                self.fetchMusic()
            }
        }
    }

    private func fetchMusic() {
        let service = ITunesNewtork(manager: NetworkManager())
        Task {
            do {
                let result = try await service.fetchMusicData(keyword: "IU")
                state.springMusic.onNext(result.results.map{ $0.toMusic() })
            } catch {
                state.error.onNext((AppError(error)))
            }
        }
    }
}
