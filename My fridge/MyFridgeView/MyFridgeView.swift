//
//  MyFridgeView.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct MyFridgeView: View {
    @ObservedObject var viewModel: MyFridgeViewModel
    @State private var showAddProductView = false

    var body: some View {
        NavigationStack {
            TabView {
                VStack {
                    Text("Мои продукты")
                        .foregroundColor(Color("TextColor"))
                        .font(.largeTitle).bold()
                    List {
                        ForEach(viewModel.rows, id: \.title) { productCard in
                            ProductRow(productTitle: productCard.title ?? "Данные отсутствуют", manufacturer: productCard.manufacturer ?? "Данные отсутствуют", productImageUrl: productCard.thumbnail ?? "Данные отсутствуют", expirationDate: productCard.expirationDateString ?? "")
                                .frame(height: 60)
                        }
                        .onDelete { indexSet in
                            StorageManager.shared.deleteAddedProduct(at: indexSet)
                        }
                    }
                    .opacity(viewModel.rows.isEmpty ? 0 : 1)
                    .onAppear {
                        viewModel.rows.forEach { product in
                            viewModel.scheduleNotificationForExpiryDate(for: product)
                            viewModel.scheduleNotificationOneDayBeforeExpiryDate(for: product)
                            viewModel.scheduleNotificationThreeDayBeforeExpiryDate(for: product)
                        }
                    }
                    Button(action: {
                        showAddProductView.toggle()
                    }) {
                        Text("Добавить продукт")
                            .frame(width: 200,height: 40)
                            .background(Color("BackgroundColor"))
                            .foregroundColor(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    }
                    .sheet(isPresented: $showAddProductView, content: {
                        AddProductView().environmentObject(viewModel)
                    })
                    Spacer()
                }
                .background(Color(.systemGroupedBackground))
                .tabItem {
                    Image(systemName: "refrigerator")
                    Text("Мои продукты")
                }
                CatalogView(viewModel: CatalogViewModel())
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Каталог")
                }
            }
            .accentColor(.yellow)
            .onAppear() {
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                tabBarAppearance.backgroundColor = UIColor(named: "BackgroundColor")
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                UITabBar.appearance().standardAppearance = tabBarAppearance
            }
        }
        .accentColor(Color("TextColor"))
    }
}

struct MyFridgeView_Previews: PreviewProvider {
    static var previews: some View {
        MyFridgeView(viewModel: MyFridgeViewModel())
    }
}
