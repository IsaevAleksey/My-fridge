//
//  MyFridgeViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 23.02.2024.
//

import SwiftUI

class MyFridgeViewModel: ObservableObject {
    @Published var rows: [ProductCard] = []
    
    init() {
        rows = StorageManager.shared.fetchAddedProducts()
        print("запрос карточки из майфриджвьюмодел")
    }
    
    func addProductManual (title: String, manufacturer: String, expirationDate: Date, expirationDateString: String) {
        let product = ProductCard(
            id: 0, title: title,
            totalRating: 0,
            description: "",
            categoryName: "",
            manufacturer: manufacturer,
            worth: [""],
            criteriaRatings: nil,
            thumbnail: "",
            expirationDate: expirationDate,
            expirationDateString: expirationDateString)
        rows.append(product)
        StorageManager.shared.addProduct(productCard: product)
    }
    
    func addScanProduct (product: ProductCard) {
        rows.append(product)
        StorageManager.shared.addProduct(productCard: product)
        
    }
    
    // Функция для установки уведомления о сроке годности продукта
    func scheduleNotificationForExpiryDate(for product: ProductCard) {
        // Создание контента уведомления
        let content = UNMutableNotificationContent()
        content.title = "\(product.title ?? "")"
        content.body = "Срок годности продукта до \(product.expirationDateString ?? "")"
        
        // Создание триггера уведомления на основе даты истечения срока годности
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: product.expirationDate ?? Date())
        
        // Создание календаря с компонентами даты и временем 9:00 утра
        var triggerDateComponents = DateComponents()
        triggerDateComponents.year = triggerDate.year
        triggerDateComponents.month = triggerDate.month
        triggerDateComponents.day = triggerDate.day
        triggerDateComponents.hour = 19
        triggerDateComponents.minute = 00
        
        // Триггер
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
        
        // Создание запроса на уведомление
        let request = UNNotificationRequest(identifier: "\(String(describing: product.title))", content: content, trigger: trigger)
        
        // Добавление запроса в центр уведомлений
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            if let error = error {
                print("Ошибка при установке уведомления: \(error.localizedDescription)")
            }
        }
    }
    
    
    // Функция для установки уведомления о истечении срока годности через день
    func scheduleNotificationOneDayBeforeExpiryDate(for product: ProductCard) {
        // Создание контента уведомления
        let content = UNMutableNotificationContent()
        content.title = "\(product.title ?? "")"
        content.body = "Срок годности продукта истекает \(product.expirationDateString ?? "")"
        
        // Создание триггера уведомления на основе даты истечения срока годности
        let dateOneDayBeforeExpiryDate = Calendar.current.date(byAdding: .day, value: -1, to: product.expirationDate ?? Date())
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dateOneDayBeforeExpiryDate ?? Date())
        
        // Создание календаря с компонентами даты и временем 9:00 утра
        var triggerDateComponents = DateComponents()
        triggerDateComponents.year = triggerDate.year
        triggerDateComponents.month = triggerDate.month
        triggerDateComponents.day = triggerDate.day
        triggerDateComponents.hour = 19
        triggerDateComponents.minute = 00
        
        // Триггер
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
        
        // Создание запроса на уведомление
//        var dateOneDayBeforeExpiryDateString: String {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd.MM.yyyy"
//            dateFormatter.locale = Locale(identifier: "ru_RU")
//            let expirationDateString = dateFormatter.string(from: dateOneDayBeforeExpiryDate ?? Date()) // Из даты в строку
//            return expirationDateString
//        }
        
        let request = UNNotificationRequest(identifier: "\(String(describing: product.title))OneDayBeforeExpiryDate", content: content, trigger: trigger)
        
        // Добавление запроса в центр уведомлений
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            if let error = error {
                print("Ошибка при установке уведомления: \(error.localizedDescription)")
            }
        }
    }
    
    
    // Функция для установки уведомления о истечении срока годности через три дня
    func scheduleNotificationThreeDayBeforeExpiryDate(for product: ProductCard) {
        // Создание контента уведомления
        let content = UNMutableNotificationContent()
        content.title = "\(product.title ?? "")"
        content.body = "Срок годности продукта истекает \(product.expirationDateString ?? "")"
        
        // Создание триггера уведомления на основе даты истечения срока годности
        let dateThreeDayBeforeExpiryDate = Calendar.current.date(byAdding: .day, value: -3, to: product.expirationDate ?? Date())
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dateThreeDayBeforeExpiryDate ?? Date())
        
        // Создание календаря с компонентами даты и временем 9:00 утра
        var triggerDateComponents = DateComponents()
        triggerDateComponents.year = triggerDate.year
        triggerDateComponents.month = triggerDate.month
        triggerDateComponents.day = triggerDate.day
        triggerDateComponents.hour = 19
        triggerDateComponents.minute = 00
        
        // Триггер
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
        
        // Создание запроса на уведомление
//        var dateThreeDayBeforeExpiryDateString: String {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd.MM.yyyy"
//            dateFormatter.locale = Locale(identifier: "ru_RU")
//            let expirationDateString = dateFormatter.string(from: dateThreeDayBeforeExpiryDate ?? Date()) // Из даты в строку
//            return expirationDateString
//        }
        let request = UNNotificationRequest(identifier: "\(String(describing: product.title))ThreeDayBeforeExpiryDate", content: content, trigger: trigger)
        
        // Добавление запроса в центр уведомлений
        let center = UNUserNotificationCenter.current()
        center.add(request) { error in
            if let error = error {
                print("Ошибка при установке уведомления: \(error.localizedDescription)")
            }
        }
    }
}

