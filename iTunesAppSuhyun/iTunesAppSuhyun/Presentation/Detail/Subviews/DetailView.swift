//
//  DetailView.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/15/25.
//

import UIKit

final class DetailView: UIView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let contentView = UIView()

    private let posterView: PosterView
    private let detailInfoView: DetailInfoView
    private var extraInfoView: UIStackView?

    var dismissButton: UIButton {
        posterView.getDismissButton()
    }

    init(info: DetailInfo) {
        self.posterView = PosterView(info: info)
        self.detailInfoView = DetailInfoView(info: info)

        if let extraInfo = info.extraInfo as? MovieExtraInfo {
            extraInfoView = MovieDetailView(info: extraInfo)
        }

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
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews(posterView, detailInfoView)

        if let extraInfoView {
            contentView.addSubview(extraInfoView)
        }
    }

    func setConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.bottom.directionalHorizontalEdges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        posterView.snp.makeConstraints { make in
            make.top.directionalHorizontalEdges.equalToSuperview()
        }

        if let extraInfoView {
            detailInfoView.snp.makeConstraints { make in
                make.top.equalTo(posterView.snp.bottom).offset(16)
                make.directionalHorizontalEdges.equalToSuperview().inset(16)
            }

            extraInfoView.snp.makeConstraints { make in
                make.top.equalTo(detailInfoView.snp.bottom).offset(20)
                make.directionalHorizontalEdges.equalToSuperview().inset(16)
                make.bottom.equalToSuperview()
            }
        } else {

            detailInfoView.snp.makeConstraints { make in
                make.top.equalTo(posterView.snp.bottom).offset(16)
                make.directionalHorizontalEdges.equalToSuperview().inset(16)
                make.bottom.lessThanOrEqualToSuperview()
            }
        }
    }
}
