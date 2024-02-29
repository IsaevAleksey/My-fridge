//
//  AddProductManualViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 24.02.2024.
//

import Foundation

class AddProductManualViewModel: ObservableObject {
    @Published var expirationDate = Date()
    @Published var productName: String = ""
    @Published var productManufactured: String = ""
    
    var expirationDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let expirationDateString = dateFormatter.string(from: expirationDate) // Из даты в строку
        return expirationDateString
    }
    
//    func addProduct(title: String, manufacturer: String) {
//        let product = ProductCard(id: 0, title: title, totalRating: 0, description: "", categoryName: "", manufacturer: manufacturer, worth: [""], criteriaRatings: nil, thumbnail: "", srok: "tratata")
//        StorageManager.shared.addProduct(productCard: product)
//    }
    
}
//extension Date {
//    var toApiString: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        return dateFormatter.string(from: self)
//    }
//}

