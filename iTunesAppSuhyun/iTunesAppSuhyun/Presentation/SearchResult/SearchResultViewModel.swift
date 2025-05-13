//
//  SearchResultViewModel.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/13/25.
//

import RxSwift

final class SearchResultViewModel: ViewModelProtocol {

    enum Action {
        case search(keyword: String, type: SearchType)
    }

    struct State {
        let searchResult = PublishSubject<[SearchResult]>()
        let error = PublishSubject<AppError>()
    }

    private let movieUseCase: MovieUseCaseProtocol
    private let podcastUseCase: PodcastUseCaseProtocol

    private let disposeBag = DisposeBag()

    var action = PublishSubject<Action>()
    var state: State = State()

    init(
        movieUseCase: MovieUseCaseProtocol,
        podcastUseCase: PodcastUseCaseProtocol
    ) {
        self.movieUseCase = movieUseCase
        self.podcastUseCase = podcastUseCase

        setBinding()
    }

    private func setBinding() {
        action
            .subscribe {[weak self] action in
            guard let self else { return }
            switch action {
            case .search(let keyword, let type):
                self.fetchData(keyword: keyword, type: type)
            }
        }.disposed(by: disposeBag)
    }

    private func fetchData(keyword: String, type: SearchType) {
        switch type {
        case .movie:
            fetchMovie(keyword: keyword)
        case .podcast:
            fetchPodcast(keyword: keyword)
        }
    }

    private func fetchMovie(keyword: String) {
        Task {
            do {
                let result = try await movieUseCase.fetchMovie(keyword: keyword)
                state.searchResult.onNext(result.map{ SearchResult(movie: $0) })
            } catch {
                if let error = error as? AppError {
                    state.error.onNext(error)
                } else {
                    state.error.onNext(AppError.unKnown(error))
                }
            }
        }
    }

    private func fetchPodcast(keyword: String) {
        Task {
            do {
                let result = try await podcastUseCase.fetchPodcast(keyword: keyword)
                state.searchResult.onNext(result.map{ SearchResult(podcast: $0) })
            } catch {
                if let error = error as? AppError {
                    state.error.onNext(error)
                } else {
                    state.error.onNext(AppError.unKnown(error))
                }
            }
        }
    }
}
