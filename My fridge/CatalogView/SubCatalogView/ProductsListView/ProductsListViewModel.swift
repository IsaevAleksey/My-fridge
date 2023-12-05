//
//  ProductsListViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 04.12.2023.
//

import Foundation

class ProductsListViewModel: ObservableObject {
    @Published var rows: [ProductViewModel] = []
    
    var productGroupTitle: String {
        productGroup.title
    }
    
    var productGroupId: Int {
        productGroup.id
    }
    
    var productGroupImageUrl: String {
        productGroup.thumbnail
    }
    
//    private let subCategories: SubCategories
    private let productGroup: ProductGroup

    init(productGroup: ProductGroup) {
        self.productGroup = productGroup
    }
    
    @MainActor func fetchProductsList(id: Int) async {
        do {
            let productsList = try await NetworkManager.shared.fetchProductsList(id: id).response
            rows = productsList.products.map {ProductViewModel(product: $0)}
        }
        catch {
            print(error)
        }
    }
}
