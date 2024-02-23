//
//  CacheManager.swift
//  My fridge
//
//  Created by Алексей Исаев on 23.02.2024.
//

import SwiftUI

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let defaults = UserDefaults.standard
    private let productKey = "productsKeys"
    
    private init() {}

    func addProduct(productCard: ProductCard) {
        var addedProducts = fetchAddedProducts()
        addedProducts.append(productCard)
        guard let data = try? JSONEncoder().encode(addedProducts) else { return }
        defaults.set(data, forKey: productKey)
    }
    
    func fetchAddedProducts() -> [ProductCard] {
        guard let data = defaults.data(forKey: productKey) else { return [] }
        guard let addedProducts = try? JSONDecoder().decode([ProductCard].self, from: data) else { return [] }
        return addedProducts
    }

    func deleteAddedProduct(at index: IndexSet) {
        var addedProducts = fetchAddedProducts()
        addedProducts.remove(atOffsets: index)
        guard let data = try? JSONEncoder().encode(addedProducts) else { return }
        defaults.set(data, forKey: productKey)
    }
}
