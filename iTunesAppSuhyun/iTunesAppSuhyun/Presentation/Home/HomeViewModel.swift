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
    private let musicUseCase: MusicUseCaseProtocol

    enum Action {
        case fetchMusic
    }

    struct State {
        var springMusic = BehaviorSubject<[Music]>(value: [])
        var summerMusic = BehaviorSubject<[Music]>(value: [])
        var autumnMusic = BehaviorSubject<[Music]>(value: [])
        var winterMusic = BehaviorSubject<[Music]>(value: [])
        var error = PublishSubject<AppError>()
    }

    var action: ((Action) -> Void)?
    var state = State()

    init(musicUseCase: MusicUseCaseProtocol) {
        self.musicUseCase = musicUseCase

        action = {[weak self] action in
            guard let self else { return }
            switch action {
            case .fetchMusic:
                self.fetchMusic()
            }
        }
    }

    private func fetchMusic() {
        Task {
            async let springMusic = musicUseCase.fetchMusic(keyword: "봄")
            async let summerMusic = musicUseCase.fetchMusic(keyword: "여름", limit: 30)
            async let autumnMusic = musicUseCase.fetchMusic(keyword: "가을", limit: 30)
            async let winterMusic = musicUseCase.fetchMusic(keyword: "겨울", limit: 15)

            state.springMusic.onNext( try await springMusic)
            state.summerMusic.onNext( try await summerMusic)
            state.autumnMusic.onNext( try await autumnMusic)
            state.winterMusic.onNext( try await winterMusic)
        }
    }
}
