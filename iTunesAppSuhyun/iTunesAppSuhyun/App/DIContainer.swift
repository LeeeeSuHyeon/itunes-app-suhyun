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
    private let podcastUsecase: PodcastUseCaseProtocol

    init() {
        let networkManager = NetworkManager(session: URLSession.shared)
        let itunesNetwork = ITunesNewtork(manager: networkManager)

        let musicRepository = MusicRepository(service: itunesNetwork)
        let movieRepository = MovieRepository(service: itunesNetwork)
        let podcastRepository = PodcastRepository(service: itunesNetwork)

        musicUseCase = MusicUseCase(repository: musicRepository)
        movieUseCase = MovieUseCase(repository: movieRepository)
        podcastUsecase = PodcastUseCase(repository: podcastRepository)

    }

    func makeHomeViewController() -> HomeViewController {
        let homeViewModel = HomeViewModel(musicUseCase: musicUseCase)
        let searchController = makeSearchController()
        return HomeViewController(homeViewModel: homeViewModel, searchController: searchController)
    }

    func makeSearchController() -> SearchController {
        let viewModel = SearchResultViewModel(
            movieUseCase: movieUseCase,
            podcastUseCase: podcastUsecase
        )
        return SearchController(viewModel: viewModel)
    }
}
