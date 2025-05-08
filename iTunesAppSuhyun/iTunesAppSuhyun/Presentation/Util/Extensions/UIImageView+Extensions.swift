//
//  UIImageView+Extensions.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import UIKit

extension UIImageView {
    func setImage(with urlString: String) {
        Task {
            let image = await ImageLoader.shared.loadImage(with: urlString)
            await MainActor.run {
                self.image = image
            }
        }
    }
}
