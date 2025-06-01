//
//  CacheManager.swift
//  My fridge
//
//  Created by Алексей Исаев on 23.02.2024.
//

import SwiftUI

enum StorageError: Error {
    case encodingError
    case decodingError
    case noData
}

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let defaults = UserDefaults.standard
    private let productKey = "productsKeys"
    
    private init() {}
    
    func addProduct(productCard: ProductCard) throws {
        var addedProducts = try fetchAddedProducts()
        
        // Проверяем, что у продукта есть ID
        guard productCard.id != nil else {
            throw StorageError.encodingError
        }
        
        // Проверяем, нет ли уже продукта с таким ID
        if let existingIndex = addedProducts.firstIndex(where: { $0.id == productCard.id }) {
            addedProducts[existingIndex] = productCard
        } else {
            addedProducts.append(productCard)
        }
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601 // Правильное кодирование дат
        
        do {
            let data = try encoder.encode(addedProducts)
            defaults.set(data, forKey: productKey)
        } catch {
            throw StorageError.encodingError
        }
    }
    
    func fetchAddedProducts() throws -> [ProductCard] {
        guard let data = defaults.data(forKey: productKey) else {
            return []
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601 // Правильное декодирование дат
        
        do {
            return try decoder.decode([ProductCard].self, from: data)
        } catch {
            throw StorageError.decodingError
        }
    }
    
    func deleteAddedProduct(at index: IndexSet) throws {
        var addedProducts = try fetchAddedProducts()
        addedProducts.remove(atOffsets: index)
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        
        do {
            let data = try encoder.encode(addedProducts)
            defaults.set(data, forKey: productKey)
        } catch {
            throw StorageError.encodingError
        }
    }
    
    func deleteAllProducts() {
        defaults.removeObject(forKey: productKey)
    }
}
