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
//    let productInfo: [ProductInfo]?
    let criteriaRatings: [CriteriaRating]?
    let thumbnail: String?
    let expirationDate: String?

//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case title = "title"
//        case totalRating = "total_rating"
//        case description = "description"
//        case categoryName = "category_name"
//        case manufacturer = "manufacturer"
//        case worth = "worth"
////        case productInfo = "product_info"
//        case criteriaRatings = "criteria_ratings"
//        case thumbnail = "thumbnail"
//    }
}

// MARK: - CriteriaRating
struct CriteriaRating: Codable, Hashable {
    let title: String?
    let value: Double?
}

//// MARK: - ProductInfo
//struct ProductInfo: Codable {
//    let name, info: String?
//}

