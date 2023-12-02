//
//  ImageCacheManager.swift
//  My fridge
//
//  Created by Алексей Исаев on 02.12.2023.
//

import SwiftUI

final class ImageCacheManager {

    static private var cache: [String: Image] = [:]

    static subscript(url: String) -> Image? {
        get {
            ImageCacheManager.cache[url]
        }
        set {
            ImageCacheManager.cache[url] = newValue
        }
    }
}
