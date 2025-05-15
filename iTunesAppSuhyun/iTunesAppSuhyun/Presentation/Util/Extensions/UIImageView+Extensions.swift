//
//  UIImageView+Extensions.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import UIKit

extension UIImageView {
    func setImage(with urlString: String, toSize size: Int? = nil) {
        var imagePath = urlString
        if let size,
           let replacedImagePath = urlString.replaceImageURL(toSize: size) {
            imagePath = replacedImagePath
        }

        Task {
            let image = await ImageLoader.shared.loadImage(with: imagePath)
            await MainActor.run {
                self.image = image
            }
        }
    }
}
