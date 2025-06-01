//
//  MyFridgeViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 23.02.2024.
//

import SwiftUI

class MyFridgeViewModel: ObservableObject {
    @Published var rows: [ProductCard] = []
    @Published var errorMessage: String?
    
    init() {
        do {
            rows = try StorageManager.shared.fetchAddedProducts()
        } catch {
            errorMessage = "Ошибка при загрузке продуктов: \(error.localizedDescription)"
            rows = []
        }
    }
    
    func addProductManual(title: String, manufacturer: String, expirationDate: Date, expirationDateString: String) {
        let product = ProductCard(
            id: UUID(),
            apiId: nil,
            title: title,
            totalRating: 0,
            description: "",
            categoryName: "",
            manufacturer: manufacturer,
            worth: [""],
            criteriaRatings: nil,
            thumbnail: "",
            expirationDate: expirationDate,
            expirationDateString: expirationDateString)
        
        do {
            try StorageManager.shared.addProduct(productCard: product)
            rows.append(product)
            scheduleAllNotificationsForProduct(product)
        } catch {
            errorMessage = "Ошибка при сохранении продукта: \(error.localizedDescription)"
        }
    }
    
    func addScanProduct(product: ProductCard) {
        let productWithId = ProductCard(
            id: UUID(),
            apiId: product.apiId,
            title: product.title,
            totalRating: product.totalRating,
            description: product.description,
            categoryName: product.categoryName,
            manufacturer: product.manufacturer,
            worth: product.worth,
            criteriaRatings: product.criteriaRatings,
            thumbnail: product.thumbnail,
            expirationDate: product.expirationDate,
            expirationDateString: product.expirationDateString)
        
        do {
            try StorageManager.shared.addProduct(productCard: productWithId)
            rows.append(productWithId)
            scheduleAllNotificationsForProduct(productWithId)
        } catch {
            errorMessage = "Ошибка при сохранении отсканированного продукта: \(error.localizedDescription)"
        }
    }
    
    private func scheduleAllNotificationsForProduct(_ product: ProductCard) {
        guard let productId = product.id,
              let expirationDate = product.expirationDate,
              let title = product.title else {
            print("Ошибка: Отсутствуют обязательные данные продукта для создания уведомлений")
            return
        }
        
        // Проверяем, что дата истечения срока годности не в прошлом
        let now = Date()
        guard expirationDate > now else {
            print("Ошибка: Дата истечения срока годности уже прошла")
            return
        }
        
        // Уведомление в день истечения срока
        scheduleNotification(
            for: productId,
            title: title,
            date: expirationDate,
            message: "Срок годности истекает сегодня",
            identifier: "product_\(productId)_expiry"
        )
        
        // Уведомление за день до истечения срока
        if let oneDayBefore = Calendar.current.date(byAdding: .day, value: -1, to: expirationDate),
           oneDayBefore > now {
            scheduleNotification(
                for: productId,
                title: title,
                date: oneDayBefore,
                message: "Срок годности истекает завтра",
                identifier: "product_\(productId)_one_day"
            )
        }
        
        // Уведомление за три дня до истечения срока
        if let threeDaysBefore = Calendar.current.date(byAdding: .day, value: -3, to: expirationDate),
           threeDaysBefore > now {
            scheduleNotification(
                for: productId,
                title: title,
                date: threeDaysBefore,
                message: "Срок годности истекает через 3 дня",
                identifier: "product_\(productId)_three_days"
            )
        }
    }
    
    private func scheduleNotification(for productId: UUID, title: String, date: Date, message: String, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = message
        content.sound = .default
        
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        dateComponents.hour = 9
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            if let error = error {
                print("Ошибка при установке уведомления: \(error.localizedDescription)")
            }
        }
    }
    
    func removeNotificationsForProduct(_ productId: UUID) {
        let center = UNUserNotificationCenter.current()
        let identifiers = [
            "product_\(productId)_expiry",
            "product_\(productId)_one_day",
            "product_\(productId)_three_days"
        ]
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
}

