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
            print("Статус разрешений на уведомления:")
            print("- Авторизация: \(settings.authorizationStatus.rawValue)")
            print("- Уведомления разрешены: \(settings.authorizationStatus == .authorized)")
            print("- Звуки разрешены: \(settings.soundSetting == .enabled)")
            print("- Бейджи разрешены: \(settings.badgeSetting == .enabled)")
            
            // Запрашиваем разрешения только если они еще не предоставлены
            if settings.authorizationStatus == .notDetermined {
                center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    DispatchQueue.main.async {
                        if granted {
                            print("✅ Разрешения на уведомления предоставлены")
                        } else {
                            print("❌ Разрешения на уведомления отклонены")
                        }
                        
                        if let error = error {
                            print("Ошибка при запросе разрешений: \(error.localizedDescription)")
                        }
                    }
                }
            } else if settings.authorizationStatus == .authorized {
                print("✅ Разрешения на уведомления уже предоставлены")
            } else {
                print("❌ Разрешения на уведомления не предоставлены")
            }
        }
        
        // НЕ удаляем все уведомления при запуске - это может удалить запланированные уведомления
        // UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    var body: some Scene {
        WindowGroup {
            MyFridgeView(viewModel: myFridgeViewModel)
                .environmentObject(myFridgeViewModel)
        }
    }
}
