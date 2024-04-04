//
//  ProductCard.swift
//  My fridge
//
//  Created by Алексей Исаев on 02.12.2023.
//

import Foundation

struct ProductCardData: Codable {
    let response: ProductCard
}

// MARK: - Response
struct ProductCard: Codable {
    let id: Int?
    let title: String?
    let totalRating: Double?
    let description: String?
    let categoryName, manufacturer: String?
    let worth: [String]?
    let criteriaRatings: [CriteriaRating]?
//    let productInfo: [ProductInfo]?
    let thumbnail: String?
    let expirationDate: Date?
    let expirationDateString: String?
}

// MARK: - CriteriaRating
struct CriteriaRating: Codable, Hashable {
    let title: String?
    let value: Double?
}

// MARK: - ProductInfo
//struct ProductInfo: Codable, Hashable {
//    let name: String?
//    let info: String?
//}


