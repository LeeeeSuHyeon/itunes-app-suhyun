//
//  UIView+Extensions.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
