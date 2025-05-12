//
//  HomeVerticalCell.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/9/25.
//

import UIKit

final class HomeVerticalCell: UICollectionViewCell {
    static let id = "HomeVerticalCell"

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let infoVerticalView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
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
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 1
        return label
    }()

    private let albumLabel: UILabel = {
        let label = UILabel()
        label.text = "album"
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 12)
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
        albumLabel.text = nil
        imageView.image = nil
    }

    func configure(with music: HomeItem.MusicItem) {
        titleLabel.text = music.title
        artistLabel.text = music.artist
        albumLabel.text = music.album
        imageView.setImage(with: music.imageURL)
    }

}
private extension HomeVerticalCell {

    func configure() {
        setLayout()
        setHierarchy()
        setConstraints()
        setAction()
    }

    func setLayout() {

    }

    func setHierarchy() {
        self.contentView.addSubviews(imageView, infoVerticalView)
        infoVerticalView.addArrangedSubviews(titleLabel, artistLabel, albumLabel)
    }

    func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
            make.width.equalTo(imageView.snp.height)
        }

        infoVerticalView.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.leading.equalTo(imageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview()
        }
    }

    func setAction() {

    }
}

