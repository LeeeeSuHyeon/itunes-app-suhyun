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
        case changedType(type: SearchType)
    }

    struct State {
        let searchResult = PublishSubject<[SearchResult]>()
        let error = PublishSubject<AppError>()
    }

    private let movieUseCase: MovieUseCaseProtocol
    private let podcastUseCase: PodcastUseCaseProtocol

    private var movieResult = [SearchResult]()
    private var podcastResult = [SearchResult]()

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
                case .changedType(let type):
                    self.changedType(type: type)
                }
            }.disposed(by: disposeBag)
    }

    private func fetchData(keyword: String, type: SearchType) {
        Task {
            async let completeFetchMovie: () = fetchMovie(keyword: keyword)
            async let completeFetchPodcast: () = fetchPodcast(keyword: keyword)
            _ = await (completeFetchMovie, completeFetchPodcast)
            changedType(type: type)
        }
    }

    private func fetchMovie(keyword: String) async {
        do {
            let result = try await movieUseCase.fetchMovie(keyword: keyword)
            movieResult = result.map{ SearchResult(movie: $0) }
        } catch {
            handleError(error)
        }
    }

    private func fetchPodcast(keyword: String) async {
        do {
            let result = try await podcastUseCase.fetchPodcast(keyword: keyword)
            podcastResult = result.map{ SearchResult(podcast: $0) }
        } catch {
            handleError(error)
        }
    }

    private func changedType(type: SearchType) {
        switch type {
        case .movie:
            state.searchResult.onNext(movieResult)
        case .podcast:
            state.searchResult.onNext(podcastResult)
        }
    }

    private func handleError(_ error: Error) {
        if let error = error as? AppError {
            state.error.onNext(error)
        } else {
            state.error.onNext(AppError.unKnown(error))
        }
    }
}
