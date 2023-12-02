//
//  ProductGroups.swift
//  My fridge
//
//  Created by Алексей Исаев on 02.12.2023.
//

import Foundation

struct ProductGroupData: Codable {
    let response: SubCategories
}

// MARK: - Response
struct SubCategories: Codable {
    let id: Int
    let title: String
    let productGroups: [ProductGroup]
}

// MARK: - ProductGroup
struct ProductGroup: Codable {
    let id: Int
    let title: String
    let thumbnail: String
}
