//
//  DIContainer.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/9/25.
//

import UIKit

final class DIContainer {
    static let shared = DIContainer()

    private let musicUseCase: MusicUseCaseProtocol

    private init() {
        let networkManager = NetworkManager(session: URLSession.shared)
        let itunesNetwork = ITunesNewtork(manager: networkManager)
        let musicRepository = MusicRepository(service: itunesNetwork)
        musicUseCase = MusicUseCase(repository: musicRepository)
    }

    func makeHomeViewController() -> HomeViewController {
        let homeViewModel = HomeViewModel(musicUseCase: musicUseCase)
        return HomeViewController(homeViewModel: homeViewModel)
    }
}
