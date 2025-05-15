//
//  DetailView.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/15/25.
//

import UIKit

final class DetailView: UIView {
    private let posterView: PosterView

    var dismissButton: UIButton {
        posterView.getDismissButton()
    }

    private let detailInfoView: DetailInfoView

    init(music: Music) {
        self.posterView = PosterView(mediaInfo: music.mediaInfo, type: .music)
        self.detailInfoView = DetailInfoView(music: music)
        super.init(frame: .zero)
        configure()
    }

    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

}

private extension DetailView {

    func configure() {
        setLayout()
        setHierarchy()
        setConstraints()
    }

    func setLayout() {
        self.backgroundColor = .white
    }

    func setHierarchy() {
        self.addSubviews(posterView, detailInfoView)
    }

    func setConstraints() {
        posterView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide)
        }

        detailInfoView.snp.makeConstraints { make in
            make.top.equalTo(posterView.snp.bottom).offset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
    }
}

