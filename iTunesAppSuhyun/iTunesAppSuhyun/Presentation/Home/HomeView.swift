//
//  HomeView.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import UIKit

final class HomeView: UIView {
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "영화, 팟캐스트"
        return searchBar
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: self.createLayout()
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.register(
            HomeBigBannerCell.self,
            forCellWithReuseIdentifier: HomeBigBannerCell.id
        )
        collectionView.register(
            HomeVerticalCell.self,
            forCellWithReuseIdentifier: HomeVerticalCell.id
        )
        collectionView.register(
            HomeBannerCell.self,
            forCellWithReuseIdentifier: HomeBannerCell.id
        )
        collectionView
            .register(
                HeaderView.self,
                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: HeaderView.id
            )
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.interSectionSpacing = 20

        return UICollectionViewCompositionalLayout(
            sectionProvider: { sectionIndex, _ in
                return HomeSection(rawValue: sectionIndex)?.section
            },
            configuration: configuration
        )
    }
}

private extension HomeView {

    func configure() {
        setLayout()
        setHierarchy()
        setConstraints()
        setAction()
    }

    func setLayout() {
        self.backgroundColor = .white
    }

    func setHierarchy() {
        self.addSubviews(searchBar, collectionView)
    }

    func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.directionalHorizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(12)
            make.directionalHorizontalEdges.bottom.equalToSuperview().inset(16)
        }
    }

    func setAction() {

    }
}
