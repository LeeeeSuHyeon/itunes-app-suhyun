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

    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
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
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBigBannerCell.id, for: indexPath)
                    (cell as? HomeBigBannerCell)?.configure(with: item)
                    return cell
                case .Summer(let item), .Autumn(let item):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeVerticalCell.id, for: indexPath)
                    (cell as? HomeVerticalCell)?.configure(with: item)
                    return cell
                case .Winter(let item):
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBannerCell.id, for: indexPath)
                    (cell as? HomeBannerCell)?.configure(with: item)
                    return cell
                }
            }
        )

        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath -> UICollectionReusableView? in
            let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HeaderView.id,
                for: indexPath
            )

            guard let section = HomeSection(rawValue: indexPath.section) else {
                return UICollectionReusableView()
            }

            (headerView as? HeaderView)?.configure(title: section.title, subTitle: section.subTitle)
            return headerView
        }
    }

    private func bindViewModel() {
        Observable.combineLatest(
            homeViewModel.state.springMusic,
            homeViewModel.state.summerMusic,
            homeViewModel.state.autumnMusic,
            homeViewModel.state.winterMusic
        )
        .observe(on: MainScheduler.instance)
        .subscribe(onNext: { [weak self] springMusic, summerMusic, autumnMusic, winterMusic in
            var snapShot = NSDiffableDataSourceSnapshot<HomeSection, HomeItem>()

            let springSection = HomeSection.Spring
            let springItem = springMusic.map { HomeItem.Spring($0) }

            let summerSection = HomeSection.Summer
            let summerItem = summerMusic.map { HomeItem.Summer($0) }

            let autumnSection = HomeSection.Autumn
            let autumnItem = autumnMusic.map { HomeItem.Autumn($0) }

            let winterSection = HomeSection.Winter
            let winterItem = winterMusic.map { HomeItem.Winter($0) }

            snapShot.appendSections([springSection, summerSection, autumnSection, winterSection])
            snapShot.appendItems(springItem, toSection: springSection)
            snapShot.appendItems(summerItem, toSection: summerSection)
            snapShot.appendItems(autumnItem, toSection: autumnSection)
            snapShot.appendItems(winterItem, toSection: winterSection)

            self?.dataSource?.apply(snapShot)
        })
        .disposed(by: disposeBag)

        homeViewModel.state.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] error in
                self?.showErrorAlert(error: error)
            }).disposed(by: disposeBag)

        homeViewModel.action?(.fetchMusic)
    }
}
