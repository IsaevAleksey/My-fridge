//
//  MyFridgeView.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct MyFridgeView: View {
    @ObservedObject var viewModel: MyFridgeViewModel
//    @StateObject var myFridgeViewModel = MyFridgeViewModel()
    @State private var showAddProductView = false


    var body: some View {
        NavigationStack {
            TabView {
                VStack {
                    Text("Мой холодильник")
                        .foregroundColor(Color("BackgroundColor"))
                        .font(.largeTitle).bold()
                    List {
                        ForEach(viewModel.rows, id: \.title) { productCard in
                            ProductRow(productTitle: productCard.title ?? "Данные отсутствуют", manufacturer: productCard.manufacturer ?? "Данные отсутствуют", productImageUrl: productCard.thumbnail ?? "Данные отсутствуют", expirationDate: productCard.expirationDate ?? "")
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
                        showAddProductView.toggle()
                    }) {
                        Text("Добавить продукт")
                            .frame(width: 200,height: 35)
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
//                viewModel.fetchAddedProducts()
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                tabBarAppearance.backgroundColor = UIColor(named: "BackgroundColor")
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                UITabBar.appearance().standardAppearance = tabBarAppearance
            }
        }
        .accentColor(Color("BackgroundColor"))
//        .task {
//            myFridgeViewModel.fetchAddedProducts()
//        }
    }
}

struct MyFridgeView_Previews: PreviewProvider {
    static var previews: some View {
        MyFridgeView(viewModel: MyFridgeViewModel())
    }
}
