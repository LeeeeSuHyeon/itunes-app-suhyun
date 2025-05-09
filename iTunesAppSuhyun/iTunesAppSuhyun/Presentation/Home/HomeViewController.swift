//
//  HomeViewController.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/7/25.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    private let homeView = HomeView()
    private let homeViewModel: HomeViewModel

    typealias DataSource = UICollectionViewDiffableDataSource<HomeSection, HomeItem>
    private var dataSource: DataSource?
    private let disposeBag = DisposeBag()

    init(homeViewModel: HomeViewModel = HomeViewModel()) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()

        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setDataSource()
        bindViewModel()
    }

    private func setDataSource() {
        dataSource = DataSource(
            collectionView: homeView.collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                switch itemIdentifier {
                case .Spring(let item):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBannerCell.id, for: indexPath)
                    (cell as? HomeBannerCell)?.configure(with: item)
                    return cell
                default:
                    return UICollectionViewCell()
                }
            }
        )

        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.id, for: indexPath)
            guard let section = HomeSection(rawValue: indexPath.section) else {
                return UICollectionReusableView()
            }
            (headerView as? HeaderView)?.configure(title: section.title, subTitle: section.subTitle)
            return headerView
        }
    }

    private func bindViewModel() {
        homeViewModel.state.springMusic
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] musics in
                var snapShot = NSDiffableDataSourceSnapshot<HomeSection, HomeItem>()
                let springSection = HomeSection.Spring
                let springItem = musics.map { HomeItem.Spring($0) }
                snapShot.appendSections([springSection])
                snapShot.appendItems(springItem, toSection: springSection)

                self?.dataSource?.apply(snapShot)
            }).disposed(by: disposeBag)

        homeViewModel.action?(.fetchMusic)
    }
}

