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
        NavigationView {
            TabView {
                VStack {
                    Text("Мои продукты")
                        .foregroundColor(Color("TextColor"))
                        .font(.largeTitle).bold()
                    
                    // Фильтр по месту хранения
                    Picker("Место хранения", selection: Binding(
                        get: { viewModel.selectedStorageLocation },
                        set: { viewModel.setStorageLocationFilter($0) }
                    )) {
                        Text("Все").tag(nil as StorageLocation?)
                        ForEach(StorageLocation.allCases, id: \.self) { location in
                            Text(location.rawValue).tag(location as StorageLocation?)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                    
                    List {
                        ForEach(viewModel.filteredRows, id: \.id) { productCard in
                            ProductRow(productTitle: productCard.title ?? "Данные отсутствуют", manufacturer: productCard.manufacturer ?? "Данные отсутствуют", productImageUrl: productCard.thumbnail ?? "Данные отсутствуют", expirationDate: productCard.expirationDateString ?? "")
                                .frame(height: 60)
                        }
                        .onDelete { indexSet in
                            // Находим индексы в полном массиве rows
                            let filteredIndices = indexSet.map { viewModel.filteredRows[$0] }
                            let fullIndices = filteredIndices.compactMap { product in
                                viewModel.rows.firstIndex { $0.id == product.id }
                            }
                            
                            // Удаляем уведомления
                            for index in fullIndices {
                                if let productId = viewModel.rows[index].id {
                                    viewModel.removeNotificationsForProduct(productId)
                                }
                            }
                            
                            // Удаляем продукты
                            do {
                                try StorageManager.shared.deleteAddedProduct(at: IndexSet(fullIndices))
                                viewModel.rows.remove(atOffsets: IndexSet(fullIndices))
                            } catch {
                                viewModel.errorMessage = "Ошибка при удалении продукта: \(error.localizedDescription)"
                            }
                        }
                    }
                    .opacity(viewModel.filteredRows.isEmpty ? 0 : 1)
                    
                    if viewModel.filteredRows.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "cart.badge.plus")
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            Text(viewModel.rows.isEmpty ? "Ваш список пуст" : "Нет продуктов в выбранном месте")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    NavigationLink {
                        AddProductView()
                            .environmentObject(viewModel)
                    } label: {
                        Text("Добавить")
                            .frame(width: 200, height: 40)
                            .background(Color("BackgroundColor"))
                            .foregroundColor(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    }
                    .padding(.bottom)
                }
                .background(Color(.systemGroupedBackground))
                .tabItem {
                    Label("Мои продукты", systemImage: "cart")
                }
                CatalogView(viewModel: CatalogViewModel())
                .tabItem {
                    Label("Каталог", systemImage: "list.bullet")
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
        .navigationViewStyle(.stack)
        .accentColor(Color("TextColor"))
        .alert("Ошибка", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { if !$0 { viewModel.errorMessage = nil } }
        )) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        } message: {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }
    }
}

struct MyFridgeView_Previews: PreviewProvider {
    static var previews: some View {
        MyFridgeView(viewModel: MyFridgeViewModel())
    }
}
