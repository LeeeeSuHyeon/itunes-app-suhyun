//
//  DetailInfoView.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/15/25.
//

import UIKit

final class DetailInfoView: UIView {

    private let horizontalInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()

    private let verticalInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()

    private let etcInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()

    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
    }()

    private let replayTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()

    init(music: Music) {
        super.init(frame: .zero)
        configure()
        configure(music: music)
    }

    init(movie: Movie) {
        super.init(frame: .zero)
        configure()
        configure(movie: movie)
    }

    init(podcast: Podcast) {
        super.init(frame: .zero)
        configure()
        configure(podcast: podcast)
    }

    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

    func configure(music: Music) {
        titleLabel.text = music.mediaInfo.title
        imageView.setImage(with: music.mediaInfo.imageURL, toSize: 100)
        subTitleLabel.text = music.album
        releaseDateLabel.text = music.mediaInfo.releaseDate.toReleaseDateFormmat()
        replayTimeLabel.text = music.durationInSeconds.toReplayTime()
    }

    func configure(movie: Movie) {
        titleLabel.text = movie.mediaInfo.title
        imageView.setImage(with: movie.mediaInfo.imageURL, toSize: 100)
        subTitleLabel.text = movie.contentAdvisoryRating
        releaseDateLabel.text = movie.mediaInfo.releaseDate.toReleaseDateFormmat()
//        replayTimeLabel.text = movie.durationInSeconds.toReplayTime()
    }

    func configure(podcast: Podcast) {
        titleLabel.text = podcast.mediaInfo.title
        imageView.setImage(with: podcast.mediaInfo.imageURL, toSize: 100)
        subTitleLabel.text = podcast.mediaInfo.artist
        releaseDateLabel.text = podcast.mediaInfo.releaseDate.toReleaseDateFormmat()
//        replayTimeLabel.text = movie.durationInSeconds.toReplayTime()
    }
}

private extension DetailInfoView {

    func configure() {
        setLayout()
        setHierarchy()
        setConstraints()
    }

    func setLayout() {
        self.backgroundColor = .white
    }

    func setHierarchy() {
        self.addSubviews(horizontalInfoStackView)
        horizontalInfoStackView.addArrangedSubviews(imageView, verticalInfoStackView)
        verticalInfoStackView.addArrangedSubviews(titleLabel, subTitleLabel, etcInfoStackView)
        etcInfoStackView.addArrangedSubviews(releaseDateLabel, replayTimeLabel)
    }

    func setConstraints() {
        horizontalInfoStackView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.size.equalTo(80)
        }
    }
}

