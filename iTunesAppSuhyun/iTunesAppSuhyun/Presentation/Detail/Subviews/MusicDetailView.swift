//
//  MusicDetailView.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/15/25.
//

import UIKit

final class MusicDetailView: UIView {
    private let posterView: PosterView

    var dismissButton: UIButton {
        posterView.getDismissButton()
    }

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

    private let albumLabel: UILabel = {
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
        self.posterView = PosterView(mediaInfo: music.mediaInfo, type: .music)
        super.init(frame: .zero)
        configure()
        configure(music: music)
    }

    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

    func configure(music: Music) {
        titleLabel.text = music.mediaInfo.title
        imageView.setImage(with: music.mediaInfo.imageURL, toSize: 100)
        albumLabel.text = music.album
        releaseDateLabel.text = music.mediaInfo.releaseDate.toReleaseDateFormmat()
        replayTimeLabel.text = music.durationInSeconds.toReplayTime()
    }
}

private extension MusicDetailView {

    func configure() {
        setLayout()
        setHierarchy()
        setConstraints()
    }

    func setLayout() {
        self.backgroundColor = .white
    }

    func setHierarchy() {
        self.addSubviews(posterView, horizontalInfoStackView)
        horizontalInfoStackView.addArrangedSubviews(imageView, verticalInfoStackView)
        verticalInfoStackView.addArrangedSubviews(titleLabel, albumLabel, etcInfoStackView)
        etcInfoStackView.addArrangedSubviews(releaseDateLabel, replayTimeLabel)
    }

    func setConstraints() {
        posterView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.directionalHorizontalEdges.equalToSuperview()
        }

        horizontalInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(posterView.snp.bottom).offset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }

        imageView.snp.makeConstraints { make in
            make.size.equalTo(80)
        }
    }
}

