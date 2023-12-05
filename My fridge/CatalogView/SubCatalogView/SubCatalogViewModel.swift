//
//  SubCatalogViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 04.12.2023.
//

import Foundation

class SubCatalogViewModel: ObservableObject {
    @Published var rows: [ProductsListViewModel] = []
    
    var categoryTitle: String {
        category.title
    }
    
    var categoryId: Int {
        category.id
    }
    
    var categoryImageUrl: String {
        category.thumbnail
    }
    
    private let category: Category

    init(category: Category) {
        self.category = category
    }
    
    @MainActor func fetchSubCategoriesList(id: Int) async {
        do {
            let subCategories = try await NetworkManager.shared.fetchSubCategories(id: id).response
            let productGroup = subCategories.productGroups
            rows = productGroup.map {ProductsListViewModel(productGroup: $0)}
        }
        catch {
            print(error)
        }
    }
}
