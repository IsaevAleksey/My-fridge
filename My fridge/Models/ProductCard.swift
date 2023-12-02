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
    let id: Int
    let title: String
    let totalRating: Int
    let description: String
    let productLink: String
    let categoryName, manufacturer: String
    let research: Research
    let recommendations: [Recommendation]
    let worth: [String]
    let productInfo: [ProductInfo]
    let criteriaRatings: [ProductCriteriaRating]
    let hasQualityMark: Bool
    let price: String
    let thumbnail: String
    let productDocuments: [ProductDocument]
    let isInFavorites: Bool

    enum CodingKeys: String, CodingKey {
        case id, title
        case totalRating
        case description
        case productLink
        case categoryName
        case manufacturer, research, recommendations, worth
        case productInfo
        case criteriaRatings
        case hasQualityMark
        case price, thumbnail
        case productDocuments
        case isInFavorites
    }
}

// MARK: - CriteriaRating
struct ProductCriteriaRating: Codable {
    let title: String
    let value: Double
}

// MARK: - ProductDocument
struct ProductDocument: Codable {
    let name: String
    let file: String
}

// MARK: - ProductInfo
struct ProductInfo: Codable {
    let name, info: String
}

// MARK: - Recommendation
struct Recommendation: Codable {
    let id: Int
    let title: String
    let totalRating: Int
    let manufacturer, price: String
    let thumbnail: String?
    let criteriaRatings: [ProductCriteriaRating]
    let categoryName: String
    let hasBadQualityMark: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title
        case totalRating
        case manufacturer, price, thumbnail
        case criteriaRatings
        case categoryName
        case hasBadQualityMark
    }
}

// MARK: - Research
struct Research: Codable {
    let id: Int
    let title, productGroup: String
    let image: String
    let date: Date

    enum CodingKeys: String, CodingKey {
        case id, title
        case productGroup
        case image, date
    }
}
