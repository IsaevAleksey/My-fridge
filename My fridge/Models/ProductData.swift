//
//  ProductData.swift
//  My fridge
//
//  Created by Алексей Исаев on 02.12.2023.
//

import Foundation

// MARK: - Welcome
struct ProductData: Codable {
    let response: ProductList
}

// MARK: - Response
struct ProductList: Codable {
    let products: [Product]
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title: String
    let totalRating: Double?
    let manufacturer: String?
    let thumbnail: String?
    let hasQualityMark: Bool?
    let categoryName: String?
    let hasBadQualityMark: Bool?
}

