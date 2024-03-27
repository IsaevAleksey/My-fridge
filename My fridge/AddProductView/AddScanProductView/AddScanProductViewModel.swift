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

    var objectWillChange = PassthroughSubject<AddScanProductViewModel, Never>()
    var productCard: ProductCard?
        
    var productId: Int {
        productCard?.id ?? 0
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
        let expirationDateString = dateFormatter.string(from: expirationDate) // Из даты в строку
        return expirationDateString
    }
    
    @MainActor func fetchPoductCardForBarcode(barcode: String) async {
        do {
            print("запрос карточки \(barcode)")
            productCard = try await NetworkManager.shared.fetchProductCardForBarcode(barcode: barcode).response
            objectWillChange.send(self)
        }
        catch {
            print(error)
        }
    }
}
