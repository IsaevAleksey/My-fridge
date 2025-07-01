//
//  MyFridgeViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 23.02.2024.
//

import SwiftUI
import UserNotifications

class MyFridgeViewModel: ObservableObject {
    @Published var rows: [ProductCard] = []
    @Published var errorMessage: String?
    @Published var selectedStorageLocation: StorageLocation? = nil // nil означает "Все"
    
    var filteredRows: [ProductCard] {
        guard let selectedLocation = selectedStorageLocation else {
            return rows // Показываем все продукты
        }
        return rows.filter { $0.storageLocation == selectedLocation }
    }
    
    init() {
        do {
            rows = try StorageManager.shared.fetchAddedProducts()
            // Планируем уведомления для всех загруженных продуктов
            for product in rows {
                scheduleAllNotificationsForProduct(product)
            }
        } catch {
            errorMessage = "Ошибка при загрузке продуктов: \(error.localizedDescription)"
            rows = []
        }
    }
    
    func addProductManual(title: String, manufacturer: String, expirationDate: Date, expirationDateString: String, storageLocation: StorageLocation = .defaultLocation) {
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
            expirationDateString: expirationDateString,
            storageLocation: storageLocation)
        
        do {
            try StorageManager.shared.addProduct(productCard: product)
            rows.append(product)
            scheduleAllNotificationsForProduct(product)
        } catch {
            errorMessage = "Ошибка при сохранении продукта: \(error.localizedDescription)"
        }
    }
    
    func addScanProduct(product: ProductCard, storageLocation: StorageLocation = .defaultLocation) {
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
            expirationDateString: product.expirationDateString,
            storageLocation: storageLocation)
        
        do {
            try StorageManager.shared.addProduct(productCard: productWithId)
            rows.append(productWithId)
            scheduleAllNotificationsForProduct(productWithId)
        } catch {
            errorMessage = "Ошибка при сохранении отсканированного продукта: \(error.localizedDescription)"
        }
    }
    
    func setStorageLocationFilter(_ location: StorageLocation?) {
        selectedStorageLocation = location
    }
    
    private func scheduleAllNotificationsForProduct(_ product: ProductCard) {
        guard let productId = product.id,
              let expirationDate = product.expirationDate,
              let title = product.title else {
            print("❌ Ошибка: Отсутствуют обязательные данные продукта для создания уведомлений")
            return
        }
        
        print("📅 Планирование уведомлений для продукта: \(title)")
        print("   - ID: \(productId)")
        print("   - Дата истечения: \(expirationDate)")
        
        // Проверяем разрешения на уведомления
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                print("❌ Разрешения на уведомления не предоставлены")
                return
            }
            
            DispatchQueue.main.async {
                self.scheduleNotificationsForProduct(product, productId: productId, expirationDate: expirationDate, title: title)
            }
        }
    }
    
    private func scheduleNotificationsForProduct(_ product: ProductCard, productId: UUID, expirationDate: Date, title: String) {
        // Проверяем, что дата истечения срока годности не в прошлом
        let now = Date()
        guard expirationDate > now else {
            print("❌ Дата истечения срока годности уже прошла: \(expirationDate)")
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
                print("❌ Ошибка при установке уведомления \(identifier): \(error.localizedDescription)")
            } else {
                print("✅ Уведомление \(identifier) запланировано на \(date)")
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
        print("🗑️ Удалены уведомления для продукта: \(productId)")
    }
}

