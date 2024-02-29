//
//  MyFridgeViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 23.02.2024.
//

import Foundation
//import Combine

class MyFridgeViewModel: ObservableObject {
    @Published var rows: [ProductCard] = []
//    var objectWillChange = PassthroughSubject<MyFridgeViewModel, Never>()
    
    init() {
        rows = StorageManager.shared.fetchAddedProducts()
    }
    
    func addProduct(product: ProductCard) {
        rows.append(product)
        StorageManager.shared.addProduct(productCard: product)
    }
    
    func addProductManual (title: String, manufacturer: String, expirationDate: String) {
        let product = ProductCard(id: 0, title: title, totalRating: 0, description: "", categoryName: "", manufacturer: manufacturer, worth: [""], criteriaRatings: nil, thumbnail: "", expirationDate: expirationDate)
        rows.append(product)
        StorageManager.shared.addProduct(productCard: product)
    }
    
    func fetchAddedProducts() {
        rows = StorageManager.shared.fetchAddedProducts()
//        objectWillChange.send(self)
    }
}
