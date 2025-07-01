//
//  AddScanProductViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 29.02.2024.
//

import Foundation
import Combine

class AddScanProductViewModel: ObservableObject {
    @Published var expirationDate = Date()
    @Published var isLoading = false
    @Published var notFoundError = false
    @Published var storageLocation: StorageLocation = .defaultLocation

    var objectWillChange = PassthroughSubject<AddScanProductViewModel, Never>()
    var productCard: ProductCard?
        
    var productId: Int? {
        productCard?.apiId
    }
    
    var productTitle: String {
        productCard?.title ?? "Нет данных"
    }
    
    var productRating: Double {
        productCard?.totalRating ?? 0.0
    }
    
    var productImageUrl: String {
        productCard?.thumbnail ?? ""
    }
    
    var productManufacturer: String {
        productCard?.manufacturer ?? "Нет данных"
    }
    
    var productDescription: String {
        productCard?.description ?? "Нет данных"
    }
    
    var productWorth: [String] {
        productCard?.worth ?? []
    }
    
    var criteriaRatings: [CriteriaRating] {
        productCard?.criteriaRatings ?? []
    }
    
    var expirationDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let expirationDateString = dateFormatter.string(from: expirationDate)
        return expirationDateString
    }
    
    @MainActor func fetchPoductCardForBarcode(barcode: String) async {
        isLoading = true
        notFoundError = false
        defer { isLoading = false }
        do {
            print("запрос карточки \(barcode)")
            let apiResponse = try await NetworkManager.shared.fetchProductCardForBarcode(barcode: barcode)
            print("Ответ от Роскачества получен")
            let apiProduct = apiResponse.response
            if let title = apiProduct.title, !title.isEmpty {
                print("Продукт найден в Роскачестве: \(title)")
                productCard = ProductCard(
                    id: nil, // UUID будет создан при добавлении в список
                    apiId: apiProduct.id,
                    title: apiProduct.title,
                    totalRating: apiProduct.totalRating,
                    description: apiProduct.description,
                    categoryName: apiProduct.categoryName,
                    manufacturer: apiProduct.manufacturer,
                    worth: apiProduct.worth,
                    criteriaRatings: apiProduct.criteriaRatings,
                    thumbnail: apiProduct.thumbnail,
                    expirationDate: expirationDate,
                    expirationDateString: expirationDateString
                )
                print("ProductCard создан из Роскачестве: title=\(productCard?.title ?? "nil"), manufacturer=\(productCard?.manufacturer ?? "nil"), thumbnail=\(productCard?.thumbnail ?? "nil")")
                objectWillChange.send(self)
                return
            } else {
                print("В Роскачестве не найдено, пробуем Open Food Facts")
                // Fallback на Open Food Facts
                do {
                    if let offProduct = try await OpenFoodFactsService.shared.fetchProduct(barcode: barcode) {
                        print("OpenFoodFacts: name=\(offProduct.product_name ?? "nil"), brand=\(offProduct.brands ?? "nil"), image_url=\(offProduct.image_url ?? "nil"), image_front_url=\(offProduct.image_front_url ?? "nil")")
                        let name = offProduct.product_name ?? "Нет данных"
                        let brand = offProduct.brands ?? "Нет данных"
                        let imageUrl = offProduct.image_url ?? offProduct.image_front_url ?? ""
                        productCard = ProductCard(
                            id: nil,
                            apiId: nil,
                            title: name,
                            totalRating: 0,
                            description: "",
                            categoryName: "",
                            manufacturer: brand,
                            worth: nil,
                            criteriaRatings: nil,
                            thumbnail: imageUrl,
                            expirationDate: expirationDate,
                            expirationDateString: expirationDateString
                        )
                        print("ProductCard создан из OpenFoodFacts: title=\(productCard?.title ?? "nil"), manufacturer=\(productCard?.manufacturer ?? "nil"), thumbnail=\(productCard?.thumbnail ?? "nil")")
                        objectWillChange.send(self)
                        return
                    } else {
                        print("Продукт не найден в Open Food Facts")
                        notFoundError = true
                        productCard = nil
                    }
                } catch {
                    print("Ошибка при запросе к Open Food Facts: \(error)")
                    notFoundError = true
                    productCard = nil
                }
            }
        }
        catch {
            print("Ошибка при запросе к Роскачеству: \(error)")
            // Fallback на Open Food Facts (на случай сетевых ошибок)
            do {
                if let offProduct = try await OpenFoodFactsService.shared.fetchProduct(barcode: barcode) {
                    print("OpenFoodFacts: name=\(offProduct.product_name ?? "nil"), brand=\(offProduct.brands ?? "nil"), image_url=\(offProduct.image_url ?? "nil"), image_front_url=\(offProduct.image_front_url ?? "nil")")
                    let name = offProduct.product_name ?? "Нет данных"
                    let brand = offProduct.brands ?? "Нет данных"
                    let imageUrl = offProduct.image_url ?? offProduct.image_front_url ?? ""
                    productCard = ProductCard(
                        id: nil,
                        apiId: nil,
                        title: name,
                        totalRating: 0,
                        description: "",
                        categoryName: "",
                        manufacturer: brand,
                        worth: nil,
                        criteriaRatings: nil,
                        thumbnail: imageUrl,
                        expirationDate: expirationDate,
                        expirationDateString: expirationDateString
                    )
                    print("ProductCard создан из OpenFoodFacts: title=\(productCard?.title ?? "nil"), manufacturer=\(productCard?.manufacturer ?? "nil"), thumbnail=\(productCard?.thumbnail ?? "nil")")
                    objectWillChange.send(self)
                    return
                } else {
                    print("Продукт не найден в Open Food Facts")
                    notFoundError = true
                    productCard = nil
                }
            } catch {
                print("Ошибка при запросе к Open Food Facts: \(error)")
                notFoundError = true
                productCard = nil
            }
        }
    }
}
