//
//  PosterView.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/15/25.
//

import UIKit

final class PosterView: UIView {
    private let info: DetailInfo

    private let pageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let dismissButton: UIButton = {
        var config = UIButton.Configuration.plain()
        var imageConfig = UIImage.SymbolConfiguration(pointSize: 24)
        config.preferredSymbolConfigurationForImage = imageConfig
        config.image = .init(systemName: "xmark.circle.fill")
        config.baseForegroundColor = .systemGray
        config.contentInsets = .zero
        let button = UIButton()
        button.configuration = config

        return button
    }()

    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.backgroundColor = .black.withAlphaComponent(0.4)
        stackView.layoutMargins = .init(top: 8, left: 16, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private let artistLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()

    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()

    init(info: DetailInfo) {
        self.info = info
        super.init(frame: .zero)
        configure()
        configure(info: info)
    }

    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

    func getDismissButton() -> UIButton {
        return self.dismissButton
    }

    func configure(info: DetailInfo) {
        pageTitleLabel.text = info.type.media
        titleLabel.text = info.mediaInfo.title
        artistLabel.text = info.mediaInfo.artist
        genreLabel.text = info.mediaInfo.genre
        imageView.setImage(
            with: info.mediaInfo.imageURL.replaceImageURL(
                toSize: 600
            ) ?? info.mediaInfo.imageURL
        )
    }

}
private extension PosterView {

    func configure() {
        setHierarchy()
        setConstraints()
    }

    func setHierarchy() {
        self.addSubviews(pageTitleLabel, imageView, dismissButton, infoStackView)
        infoStackView.addArrangedSubviews(genreLabel, titleLabel, artistLabel)
    }

    func setConstraints() {
        pageTitleLabel.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(60)
        }

        imageView.snp.makeConstraints { make in
            make.top.equalTo(pageTitleLabel.snp.bottom)
            make.directionalHorizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(imageView.snp.width).multipliedBy(1.2)
        }

        dismissButton.snp.makeConstraints { make in
            make.top.equalTo(imageView).offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(44)
        }

        infoStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
    }
}

