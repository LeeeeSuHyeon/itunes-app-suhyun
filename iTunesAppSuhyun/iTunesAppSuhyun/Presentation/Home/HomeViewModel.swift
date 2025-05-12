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
        var springMusic = BehaviorSubject<[HomeItem.MusicItem]>(value: [])
        var summerMusic = BehaviorSubject<[HomeItem.MusicItem]>(value: [])
        var autumnMusic = BehaviorSubject<[HomeItem.MusicItem]>(value: [])
        var winterMusic = BehaviorSubject<[HomeItem.MusicItem]>(value: [])
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

            do {
                state.springMusic.onNext( try await transform(from: springMusic))
                state.summerMusic.onNext( try await transform(from: summerMusic))
                state.autumnMusic.onNext( try await transform(from: autumnMusic))
                state.winterMusic.onNext( try await transform(from: winterMusic))
            } catch {
                state.error.onNext(error as? AppError ?? AppError.unKnown(error))
            }
        }
    }

    private func transform(from musics: [Music]) -> [HomeItem.MusicItem] {
        return musics.map {
            HomeItem.MusicItem(
                musicId: $0.musicId,
                title: $0.title,
                artist: $0.artist,
                album: $0.album,
                imageURL: $0.imageURL,
                releaseDate: $0.releaseDate,
                durationInSeconds: $0.durationInSeconds
            )
        }
    }
}
