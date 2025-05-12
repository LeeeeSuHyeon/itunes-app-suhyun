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
        var springItem = PublishSubject<[HomeItem]>()
        var summerItem = PublishSubject<[HomeItem]>()
        var autumnItem = PublishSubject<[HomeItem]>()
        var winterItem = PublishSubject<[HomeItem]>()
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
            do {
                try await withThrowingTaskGroup(of: (HomeSection, [Music]).self) {[weak self] group in
                    guard let self else { return }

                    HomeSection.allCases.forEach { section in
                        group.addTask {
                            let musics = try await self.musicUseCase.fetchMusic(keyword: section.keyword, limit: section.limit)
                            return (section, musics)
                        }
                    }

                    for try await (section, musics) in group {
                        let items = musics.map { section.createItem(from: $0) }
                        getSubject(for: section).onNext(items)
                    }
                }
            } catch {
                state.error.onNext(error as? AppError ?? AppError.unKnown(error))
            }
        }
    }

    private func getSubject(for section: HomeSection) -> PublishSubject<[HomeItem]> {
        switch section {
        case .spring: return state.springItem
        case .summer: return state.summerItem
        case .autumn: return state.autumnItem
        case .winter: return state.winterItem
        }
    }
}
