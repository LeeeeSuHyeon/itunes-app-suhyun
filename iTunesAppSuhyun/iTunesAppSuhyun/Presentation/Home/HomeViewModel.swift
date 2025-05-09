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
        var summerMusic = BehaviorSubject<[Music]>(value: [])
        var autumnMusic = BehaviorSubject<[Music]>(value: [])
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
                //TODO: 4계절 병렬 처리
                let springMusic = try await service.fetchMusicData(keyword: "봄")
                let summerMusic = try await service.fetchMusicData(keyword: "여름", limit: 30)
                let autumnMusic = try await service.fetchMusicData(keyword: "가을", limit: 30)

                state.springMusic.onNext(springMusic.results.map{ $0.toMusic() })
                state.summerMusic.onNext(summerMusic.results.map{ $0.toMusic() })
                state.autumnMusic.onNext(autumnMusic.results.map{ $0.toMusic() })
            } catch {
                state.error.onNext((AppError(error)))
            }
        }
    }
}
