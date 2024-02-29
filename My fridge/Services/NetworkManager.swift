//
//  NetworkManager.swift
//  My fridge
//
//  Created by Алексей Исаев on 02.12.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init () {}
    
    func fetchCategory() async throws -> CategoriesData {

        guard let url = URL(string: "https://rskrf.ru/rest/1/catalog/categories/8/") else {
            throw NetworkError.invalidURL
        }
        
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            throw NetworkError.noData
        }
        guard let categoriesData = try? JSONDecoder().decode(CategoriesData.self, from: data) else {
            throw NetworkError.decodingError
        }
        return categoriesData
    }
        
    func fetchSubCategories(id: Int) async throws -> ProductGroupData {

        guard let url = URL(string: "https://rskrf.ru/rest/1/catalog/categories/\(id)/productGroups/") else {
            throw NetworkError.invalidURL
        }
        
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            throw NetworkError.noData
        }
        guard let productGroupData = try? JSONDecoder().decode(ProductGroupData.self, from: data) else {
            throw NetworkError.decodingError
        }
        return productGroupData
    }
    
    func fetchProductsList(id: Int) async throws -> ProductData {

        guard let url = URL(string: "https://rskrf.ru/rest/1/catalog/products/\(id)/") else {
            throw NetworkError.invalidURL
        }
        
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            throw NetworkError.noData
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let productData = try? decoder.decode(ProductData.self, from: data) else {
            throw NetworkError.decodingError
        }
        return productData
    }
    
    func fetchProductCard(id: Int) async throws -> ProductCardData {

        guard let url = URL(string: "https://rskrf.ru/rest/1/product/\(id)/") else {
            throw NetworkError.invalidURL
        }
        
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            throw NetworkError.noData
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let productCardData = try? decoder.decode(ProductCardData.self, from: data) else {
            throw NetworkError.decodingError
        }
        return productCardData
    }
    
    func fetchProductCardForBarcode(barcode: String) async throws -> ProductCardData {

        guard let url = URL(string: "https://rskrf.ru/rest/1/search/barcode?barcode=\(barcode)") else {
            throw NetworkError.invalidURL
        }
        
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            throw NetworkError.noData
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let productCardData = try? decoder.decode(ProductCardData.self, from: data) else {
            throw NetworkError.decodingError
        }
        return productCardData
    }
}
