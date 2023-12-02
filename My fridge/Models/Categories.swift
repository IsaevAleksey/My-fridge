//
//  Categories.swift
//  My fridge
//
//  Created by Алексей Исаев on 02.12.2023.
//

import Foundation

struct CategoriesData: Codable {
    let response: [Category]
}

struct Category: Codable {
    let id: Int
    let title: String
    let icon: String
    let thumbnail: String
}
