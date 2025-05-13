//
//  SearchResultView.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/13/25.
//

import UIKit

final class SearchResultView: UIView {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UIScreen.main.bounds.height * 0.6
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.id)
//        tableView.register(<#T##nib: UINib?##UINib?#>, forHeaderFooterViewReuseIdentifier: <#T##String#>)
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }

}
private extension SearchResultView {

    func configure() {
        setLayout()
        setHierarchy()
        setConstraints()
    }

    func setLayout() {
        self.backgroundColor = .white
    }

    func setHierarchy() {
        addSubviews(tableView)
    }

    func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(safeAreaLayoutGuide)
            make.directionalHorizontalEdges.equalToSuperview().inset(12)
        }
    }
}
