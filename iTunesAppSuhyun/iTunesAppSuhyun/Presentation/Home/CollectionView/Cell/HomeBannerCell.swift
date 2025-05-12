//
//  HomeBannerCell.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/9/25.
//

import UIKit

final class HomeBannerCell: UICollectionViewCell {
    static let id = "HomeBannerCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let infoVerticalView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        return label
    }()

    private let artistLabel: UILabel = {
        let label = UILabel()
        label.text = "artist"
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 12, weight: .bold)
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

    override func prepareForReuse() {
        super.prepareForReuse()

        titleLabel.text = nil
        artistLabel.text = nil
        imageView.image = nil
    }

    func configure(with music: Music) {
        titleLabel.text = music.title
        artistLabel.text = music.artist
        imageView.setImage(with: music.imageURL)
    }
}

private extension HomeBannerCell {

    func configure() {
        setLayout()
        setHierarchy()
        setConstraints()
        setAction()
    }

    func setLayout() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.backgroundColor = .systemGray6
    }

    func setHierarchy() {
        infoVerticalView.addArrangedSubviews(titleLabel, artistLabel)
        self.contentView.addSubviews(imageView, infoVerticalView)
    }

    func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }

        infoVerticalView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.bottom.directionalHorizontalEdges.equalToSuperview().inset(8)
        }
    }

    func setAction() {

    }
}

