//
//  CatalogViewViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 04.12.2023.
//

import Foundation

class CatalogViewModel: ObservableObject {
    @Published var rows: [SubCatalogViewModel] = []

    @MainActor func fetchCategoriesList() async {
        do {
            let categoriesList = try await NetworkManager.shared.fetchCategory().response
            rows = categoriesList.map {SubCatalogViewModel(category: $0)}
        }
        catch {
            print(error)
        }
    }
}


