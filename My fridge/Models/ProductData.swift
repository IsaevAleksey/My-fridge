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
//    let criteriaRatings: [CriteriaRating]
    let hasBadQualityMark: Bool?

//    enum CodingKeys: String, CodingKey {
//        case id, title
//        case totalRating
//        case manufacturer, price, thumbnail
//        case hasQualityMark
//        case criteriaRatings
//        case hasBadQualityMark
//    }
}

// MARK: - CriteriaRating
//struct CriteriaRating: Codable {
//    let title: Title
//    let value: Double
//}

//enum Title: String, Codable {
//    case безопасность = "Безопасность "
//    case достоверностьМаркировки = "Достоверность маркировки"
//    case качество = "Качество"
//    case консерванты = "Консерванты"
//    case красители = "Красители"
//    case микробиология = "Микробиология"
//    case органолептическиеПоказатели = "Органолептические показатели"
//    case основныеПищевыеВещества = "Основные пищевые вещества"
//    case пестициды = "Пестициды"
//    case токсины = "Токсины"
//    case физикоХимическиеПоказатели = "Физико-химические показатели"
//}

