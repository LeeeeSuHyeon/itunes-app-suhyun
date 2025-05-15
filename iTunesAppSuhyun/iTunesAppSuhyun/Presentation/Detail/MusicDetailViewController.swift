//
//  MusicDetailViewController.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/15/25.
//

import UIKit
import RxCocoa
import RxSwift

final class MusicDetailViewController: UIViewController {
    private let detailView: DetailView
    private let disposeBag = DisposeBag()

    init(music: Music) {
        detailView = DetailView(music: music)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bindView()
    }

    private func bindView() {
        detailView.dismissButton.rx.tap.bind {[weak self] in
            self?.dismiss(animated: true)
        }.disposed(by: disposeBag)
    }
}
