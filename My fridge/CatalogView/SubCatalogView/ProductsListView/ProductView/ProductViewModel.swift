//
//  ProductViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 04.12.2023.
//
import Combine
import Foundation

class ProductViewModel: ObservableObject {
    @Published var rows: [ProductViewModel] = []
    var objectWillChange = PassthroughSubject<ProductViewModel, Never>()
    var productCard: ProductCard?
    
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
    
    var productInfoStats: [String:String] {
        var productInform: [String:String] = [:]
        guard let productInfo = productCard?.productInfo else {return [:]}
        let name: [String] = productInfo.map {$0.name}
        let info: [String] = productInfo.map {$0.info}
        
        for i in 0..<name.count {
            let key = name[i]
            productInform[key] = info[i]
        }
        return productInform
            
//        for i in 0...productInfo.count {
//            for j in 0...productInfo.count {
//                let info = poissonProbability(for: i, and: j)
//                let stats = "\(i)-\(j)"
//                productInform.append(stats)
//                stats[key] = probability
//            }
        }
        
        
//        var productInfoName = [""]
//        productInfoName = productCard?.productInfo.map {$0.name} ?? []
//        return productInfoName
//    }
//
//    var productInfoInfo: [String] {
//        var productInfoInfo = [""]
//        productInfoInfo = productCard?.productInfo.map {$0.info} ?? []
//        return productInfoInfo
//    }
//    var productDescription: String {
//        productCard?.description ?? "Описание отсутствует"
//    }
//    var categoryName: String {
//        product.categoryName
//    }
    
    private let product: Product

    init (product: Product) {
        self.product = product
    }
    
    
    @MainActor func fetchPoductCard(id: Int) async {
        do {
            productCard = try await NetworkManager.shared.fetchProductCard(id: id).response
            objectWillChange.send(self)
            print("запрос карточки")
        }
        catch {
            print(error)
        }
    }
}
