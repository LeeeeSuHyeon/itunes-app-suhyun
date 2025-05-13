//
//  DIContainer.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/9/25.
//

import UIKit

final class DIContainer {

    private let musicUseCase: MusicUseCaseProtocol
    private let movieUseCase: MovieUseCaseProtocol

    init() {
        let networkManager = NetworkManager(session: URLSession.shared)
        let itunesNetwork = ITunesNewtork(manager: networkManager)
        let musicRepository = MusicRepository(service: itunesNetwork)
        let movieRepository = MovieRepository(service: itunesNetwork)
        musicUseCase = MusicUseCase(repository: musicRepository)
        movieUseCase = MovieUseCase(repository: movieRepository)
    }

    func makeHomeViewController() -> HomeViewController {
        let homeViewModel = HomeViewModel(musicUseCase: musicUseCase)
        let searchResultVC = makeSearchResultViewController()
        return HomeViewController(homeViewModel: homeViewModel, searchResultVC: searchResultVC)
    }

    func makeSearchResultViewController() -> SearchResultViewController {
        let viewModel = SearchResultViewModel(movieUseCase: movieUseCase)
        return SearchResultViewController(viewModel: viewModel)
    }
}
