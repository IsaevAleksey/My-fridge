//
//  AddProductManualViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 24.02.2024.
//

import Foundation

class AddProductManualViewModel: ObservableObject {
    @Published var date = Date()
    @Published var productName: String = ""
    @Published var productManufactured: String = ""
    
    func addProduct(title: String, manufacturer: String) {
        let product = ProductCard(id: 0, title: title, totalRating: 0, description: "", categoryName: "", manufacturer: manufacturer, worth: [""], criteriaRatings: nil, thumbnail: "")
        StorageManager.shared.addProduct(productCard: product)
    }
    
}
