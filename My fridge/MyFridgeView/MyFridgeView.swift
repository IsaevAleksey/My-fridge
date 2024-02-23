//
//  MyFridgeView.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct MyFridgeView: View {
    @State var showAddProductView = false
    @StateObject var viewModel: MyFridgeViewModel

    var body: some View {
        NavigationStack {
            TabView {
                VStack {
                    Text("Мой холодильник")
                        .foregroundColor(Color("BackgroundColor"))
                        .font(.largeTitle).bold()
                    List {
                        ForEach(viewModel.rows, id: \.title) { productCard in
                            ProductRow(productTitle: productCard.title ?? "Данные отсутствуют", manufacturer: productCard.manufacturer ?? "Данные отсутствуют", productImageUrl: productCard.thumbnail ?? "Данные отсутствуют")
                                .frame(height: 60)
                        }
                        .onDelete { indexSet in
                            StorageManager.shared.deleteAddedProduct(at: indexSet)
                        }
                    }
                    .opacity(viewModel.rows.isEmpty ? 0 : 1)
//                    .background(Color.yellow)
//                    .scrollContentBackground(.hidden)
                    Button(action: {
                        self.showAddProductView.toggle()
                    }) {
                        Text("Добавить продукт")
                            .frame(width: 200,height: 35)
                            .background(Color("BackgroundColor"))
                            .foregroundColor(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    }
                    .sheet(isPresented: $showAddProductView, content: {
                        AddProductView()
                    })
                    Spacer()
                }
                .background(Color(.systemGroupedBackground))
                .tabItem {
                    Image(systemName: "refrigerator")
                    Text("Home")
                }
                CatalogView(viewModel: CatalogViewModel())
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Catalog")
                }
            }
            .accentColor(.yellow)
            .onAppear() {
                viewModel.fetchAddedProducts()
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                tabBarAppearance.backgroundColor = UIColor(named: "BackgroundColor")
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                UITabBar.appearance().standardAppearance = tabBarAppearance
            }
        }
        .accentColor(Color("BackgroundColor"))
//        .onAppear {
//            viewModel.fetchAddedProducts()
//        }
    }
}

struct MyFridgeView_Previews: PreviewProvider {
    static var previews: some View {
        MyFridgeView(viewModel: MyFridgeViewModel())
    }
}
