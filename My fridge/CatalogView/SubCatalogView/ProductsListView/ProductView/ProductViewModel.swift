//
//  ProductViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 04.12.2023.
//

import Foundation

class ProductViewModel: ObservableObject {
    @Published var rows: [ProductViewModel] = []
    
    var productId: Int {
        product.id
    }
    
    var productTitle: String {
        product.title
    }
    
    var productRating: Double {
        product.totalRating
    }
    
    var productImageUrl: String {
        product.thumbnail
    }
    
    var productManufacturer: String {
        product.manufacturer
    }

    var categoryName: String {
        product.categoryName
    }
    
    private let product: Product

    init (product: Product) {
        self.product = product
    }
}
