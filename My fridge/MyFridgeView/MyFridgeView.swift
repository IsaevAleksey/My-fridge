//
//  MyFridgeView.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct MyFridgeView: View {
    @State var showAddProductView = false

    
    var body: some View {
        NavigationStack {
            TabView {
                VStack {
                    Text("Мой холодильник")
                        .foregroundColor(Color("BackgroundColor"))
                        .font(.largeTitle).bold()
                    List {
                        ProductRow()
//                            .listRowBackground(Color(.yellow))
                        ProductRow()
                        ProductRow()
                    }
                    .navigationTitle("asdasd")
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
                let tabBarAppearance = UITabBarAppearance()
                tabBarAppearance.configureWithOpaqueBackground()
                tabBarAppearance.backgroundColor = UIColor(named: "BackgroundColor")
                UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                UITabBar.appearance().standardAppearance = tabBarAppearance
//                UITabBar.appearance().backgroundColor = .gray
            }
        }
        .accentColor(Color("BackgroundColor"))
    }
}

struct MyFridgeView_Previews: PreviewProvider {
    static var previews: some View {
        MyFridgeView()
    }
}
