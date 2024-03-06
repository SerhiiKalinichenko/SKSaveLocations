//
//  ImageLoader.swift
//  SKSaveLocations
//
//  Created by Serhii Kalinichenko on 29.02.2024.
//

import UIKit

enum ImageLoader {
    static func loadImage(url: URL?) async -> UIImage? {
        do {
            guard let url else {
                return nil
            }
            if let cach = URLCache.shared.cachedResponse(for: .init(url: url)) {
                return UIImage(data: cach.data)
            } else {
                let (data, response) = try await URLSession.shared.data(from: url)
                URLCache.shared.storeCachedResponse(.init(response: response, data: data), for: .init(url: url))
                if let image = UIImage(data: data) {
                    return image
                }
                return nil
            }
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }
}
