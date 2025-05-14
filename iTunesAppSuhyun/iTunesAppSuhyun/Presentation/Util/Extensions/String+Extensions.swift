//
//  String+Extensions.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/14/25.
//

import Foundation

extension String {
    func replaceImageURL(toSize size: Int) -> String? {
        let pattern = #"\d+x\d+bb\.jpg$"#
        guard let range = self.range(of: pattern, options: .regularExpression) else {
            return nil
        }

        let newSizeString = "\(size)x\(size)bb.jpg"
        return self.replacingCharacters(in: range, with: newSizeString)
    }
}
