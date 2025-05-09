//
//  HeaderView.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/9/25.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    static let id = "HeaderView"

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemGray2
        label.numberOfLines = 1
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

    func configure(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}

private extension HeaderView {

    func configure() {
        setLayout()
        setHierarchy()
        setConstraints()
    }

    func setLayout() {

    }

    func setHierarchy() {
        self.addSubviews(titleLabel, subTitleLabel)
    }

    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview()
        }

        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
        }
    }
}

