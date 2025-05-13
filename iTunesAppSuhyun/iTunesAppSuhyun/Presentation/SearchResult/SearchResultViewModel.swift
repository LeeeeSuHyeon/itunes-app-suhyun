//
//  SearchResultViewModel.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/13/25.
//

import RxSwift

final class SearchResultViewModel: ViewModelProtocol {

    enum Action {
        case search(keyword: String)
    }

    struct State {
        let movieResult = PublishSubject<[Movie]>()
        let error = PublishSubject<AppError>()
    }

    private let movieUseCase: MovieUseCaseProtocol
    private let disposeBag = DisposeBag()

    var action = PublishSubject<Action>()
    var state: State = State()

    init(movieUseCase: MovieUseCaseProtocol) {
        self.movieUseCase = movieUseCase
        setBinding()
    }

    private func setBinding() {
        action.subscribe {[weak self] action in
            guard let self else { return }
            switch action {
            case .search(let keyword):
                self.fetchMovie(keyword: keyword)
            }
        }.disposed(by: disposeBag)
    }

    private func fetchMovie(keyword: String) {
        Task {
            do {
                let result = try await movieUseCase.fetchMovie(keyword: keyword)
                state.movieResult.onNext(result)
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
