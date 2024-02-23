//
//  MyFridgeViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 23.02.2024.
//

import Foundation
import Combine

class MyFridgeViewModel: ObservableObject {
    @Published var rows: [ProductCard] = []
    var objectWillChange = PassthroughSubject<MyFridgeViewModel, Never>()

    
    func fetchAddedProducts() {
        rows = StorageManager.shared.fetchAddedProducts()
        objectWillChange.send(self)
    }
}
