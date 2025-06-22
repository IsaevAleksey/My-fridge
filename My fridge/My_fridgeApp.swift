//
//  My_fridgeApp.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI
import UserNotifications

@main
struct My_fridgeApp: App {
    @StateObject var myFridgeViewModel = MyFridgeViewModel()
    
    init() {
        setupNotifications()
    }
    
    private func setupNotifications() {
        let center = UNUserNotificationCenter.current()
        
        // Проверяем текущие настройки уведомлений
        center.getNotificationSettings { settings in
            // Запрашиваем разрешения только если они еще не предоставлены
            if settings.authorizationStatus == .notDetermined {
                center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if let error = error {
                        print("Ошибка при запросе разрешений: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MyFridgeView(viewModel: myFridgeViewModel)
        }
    }
}
