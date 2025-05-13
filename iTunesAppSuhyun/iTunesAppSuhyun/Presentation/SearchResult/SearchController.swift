//
//  SearchController.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/12/25.
//

import UIKit

final class SearchController: UISearchController {

    override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)

        configure(with: searchResultsController)
    }

    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

}
private extension SearchController {

    func configure(with updater: UIViewController?) {
        self.searchResultsUpdater = updater as? UISearchResultsUpdating
        self.obscuresBackgroundDuringPresentation = true

        let allCasesTitle = SearchType.allCases.map{$0.title}
        self.searchBar.placeholder = allCasesTitle.joined(separator: ", ")
        self.searchBar.scopeButtonTitles = allCasesTitle
        self.delegate = self
    }
}


extension SearchController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        self.searchBar.setShowsScope(true, animated: true)
    }

    func didDismissSearchController(_ searchController: UISearchController) {
        self.searchBar.setShowsScope(false, animated: true)
    }
}
