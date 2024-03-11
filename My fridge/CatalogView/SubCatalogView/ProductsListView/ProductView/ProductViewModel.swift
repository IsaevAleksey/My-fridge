//
//  ProductViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 04.12.2023.
//
import Combine
import Foundation

class ProductViewModel: ObservableObject {
//    @Published var rows: [ProductViewModel] = []
    var objectWillChange = PassthroughSubject<ProductViewModel, Never>()
    var productCard: ProductCard?
    
    var productId: Int {
        product.id
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
            productCard = try await NetworkManager.shared.fetchProductCard(id: id).response
            objectWillChange.send(self)
        }
        catch {
            print(error)
        }
    }
}
