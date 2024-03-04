//
//  My_fridgeApp.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

@main
struct My_fridgeApp: App {
    @StateObject var myFridgeViewModel = MyFridgeViewModel()
    
    init() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { result, error in
            if let error = error {
                print(error)
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MyFridgeView(viewModel: myFridgeViewModel)

        }
    }
}
