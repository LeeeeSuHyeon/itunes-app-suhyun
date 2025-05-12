//
//  ImageLoader.swift
//  iTunesAppSuhyun
//
//  Created by 이수현 on 5/8/25.
//

import UIKit
import os

final class ImageLoader {
    static let shared = ImageLoader()

    private let cache = NSCache<NSString, UIImage>()
    private let taskStore = OngoingTaskStore()      // 현재 다운 중인 이미지 URL
    private let expiryStore = ExpiryDateStore()     // 만료 기간
    private let ttl: TimeInterval = 60 * 60 * 24    // 24시간

    private init() {
        cache.totalCostLimit = 50 * 1_000_000 // 50MB
    }

    func loadImage(with urlString: String) async -> UIImage? {
        if let cachedImage = cache.object(forKey: urlString as NSString),
           let expiryDate = await expiryStore.getExpiryDate(for: urlString) {

            if expiryDate > Date() {
                os_log("[ImageLoader]: 캐시 이미지 사용", type: .default)
                return cachedImage
            }

            Task {
                os_log("[ImageLoader]: 캐시 이미지 기간 만료", type: .default)
                await expiryStore.removeExpiryDate(for: urlString)
            }
        }

        if let ongoingTask = await taskStore.getTask(for: urlString) {
            return await ongoingTask.value
        }

        guard let url = URL(string: urlString) else { return nil }

        let task: Task<UIImage?, Never> = Task {
            defer {
                Task { await taskStore.removeTask(for: urlString) }
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let image = UIImage(data: data) else { return nil }

                cache.setObject(image, forKey: urlString as NSString, cost: data.count)
                await expiryStore.setExpiryDate(date: Date().addingTimeInterval(ttl), for: urlString)
                return image
            } catch {
                os_log("[ImageLoader]: 이미지 다운로드 실패", type: .fault)
                return nil
            }
        }

        await taskStore.setTask(task, for: urlString)
        return await task.value
    }
}
