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

    var body: some Scene {
        WindowGroup {
            MyFridgeView(viewModel: myFridgeViewModel)

        }
    }
}
