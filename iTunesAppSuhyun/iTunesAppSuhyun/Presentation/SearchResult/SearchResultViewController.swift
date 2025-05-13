//
//  SearchResultViewController.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/12/25.
//

import UIKit
import RxSwift
import RxCocoa
import os

final class SearchResultViewController: UIViewController {
    private let searchResultView = SearchResultView()
    private let viewModel: SearchResultViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: SearchResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = searchResultView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }

    private func bindViewModel() {
        viewModel.state.movieResult
            .observe(on: MainScheduler.instance)
            .bind(to: searchResultView.tableView.rx.items) { tableView, row, movieItem in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultCell.id) as? SearchResultCell else { return UITableViewCell() }
                cell.configure(with: movieItem, index: row)
                return cell
            }.disposed(by: disposeBag)

        viewModel.state.error
            .observe(on: MainScheduler.instance)
            .subscribe {[weak self] error in
                os_log(.error, "%@", error.debugDescription)
                self?.showErrorAlert(error: error)
            }.disposed(by: disposeBag)
    }
}

extension SearchResultViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }

        let selectedIndex = searchController.searchBar.selectedScopeButtonIndex
        switch SearchType(rawValue: selectedIndex) {
        case .movie: //TODO: Movie 검색
            viewModel.action
//                .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
                .onNext(.search(keyword: text))
            return
        case .podcast: //TODO: PodCast 검색
            return
        case .none:
            return
        }
    }
}
