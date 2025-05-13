//
//  HomeView.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import UIKit

final class HomeView: UIView {
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
        collectionView.register(
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
        configuration.interSectionSpacing = 30

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
    }

    func setLayout() {
        self.backgroundColor = .white
    }

    func setHierarchy() {
        self.addSubviews(collectionView)
    }

    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(12)
            make.leading.equalToSuperview().inset(16)
            make.trailing.bottom.equalToSuperview()
        }
    }
}
