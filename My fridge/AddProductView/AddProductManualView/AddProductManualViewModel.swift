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
}

