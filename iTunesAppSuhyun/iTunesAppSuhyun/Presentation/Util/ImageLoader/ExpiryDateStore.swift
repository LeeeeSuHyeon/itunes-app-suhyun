//
//  ExpiryDateStore.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import UIKit

final actor ExpiryDateStore {
    private var expiryDates: [String: Date] = [:]

    func getExpiryDate(for key: String) -> Date? {
        return expiryDates[key]
    }

    func setExpiryDate(date: Date, for key: String) {
        expiryDates[key] = date
    }

    func removeExpiryDate(for key: String) {
        expiryDates[key] = nil
    }
}
