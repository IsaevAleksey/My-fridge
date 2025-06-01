//
//  ProductViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 04.12.2023.
//
import Combine
import Foundation

class ProductViewModel: ObservableObject {
    var objectWillChange = PassthroughSubject<ProductViewModel, Never>()
    var productCard: ProductCard?
    
    var productId: Int {
        product.id // API возвращает Int ID
    }
    
    var productTitle: String {
        product.title
    }
    
    var productRating: Double {
        product.totalRating ?? 0.0
    }
    
    var productImageUrl: String {
        product.thumbnail ?? ""
    }
    
    var productManufacturer: String {
        product.manufacturer ?? ""
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
    
    private let product: Product

    init (product: Product) {
        self.product = product
    }
    
    @MainActor func fetchPoductCard(id: Int) async {
        do {
            print("запрос карточки \(id)")
            let apiResponse = try await NetworkManager.shared.fetchProductCard(id: id)
            let apiProduct = apiResponse.response
            
            // Создаем ProductCard из API ответа
            productCard = ProductCard(
                id: nil,
                apiId: apiProduct.id,
                title: apiProduct.title,
                totalRating: apiProduct.totalRating,
                description: apiProduct.description,
                categoryName: apiProduct.categoryName,
                manufacturer: apiProduct.manufacturer,
                worth: apiProduct.worth,
                criteriaRatings: apiProduct.criteriaRatings,
                thumbnail: apiProduct.thumbnail,
                expirationDate: nil,
                expirationDateString: nil
            )
            objectWillChange.send(self)
        }
        catch {
            print(error)
        }
    }
}
