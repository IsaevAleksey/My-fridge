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
    let id: UUID? // Для локальных продуктов
    let apiId: Int? // Для продуктов из API
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
    let storageLocation: StorageLocation?
    
    init(id: UUID? = nil,
         apiId: Int? = nil,
         title: String?,
         totalRating: Double?,
         description: String?,
         categoryName: String?,
         manufacturer: String?,
         worth: [String]?,
         criteriaRatings: [CriteriaRating]?,
         thumbnail: String?,
         expirationDate: Date?,
         expirationDateString: String?,
         storageLocation: StorageLocation? = .defaultLocation) {
        self.id = id
        self.apiId = apiId
        self.title = title
        self.totalRating = totalRating
        self.description = description
        self.categoryName = categoryName
        self.manufacturer = manufacturer
        self.worth = worth
        self.criteriaRatings = criteriaRatings
        self.thumbnail = thumbnail
        self.expirationDate = expirationDate
        self.expirationDateString = expirationDateString
        self.storageLocation = storageLocation
    }
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


