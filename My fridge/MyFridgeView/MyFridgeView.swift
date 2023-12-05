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
                        .font(.largeTitle).bold()
                    List {
                        ProductRow()
                        ProductRow()
                        ProductRow()
                    }
                    Button(action: {
                        self.showAddProductView.toggle()
                    }) {
                        Text("Добавить продукт")
                            .frame(width: 200,height: 35)
                            .background(Color.black)
                            .foregroundColor(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    }
                    .sheet(isPresented: $showAddProductView, content: {
                        AddProductView()
                    })
                    Spacer()
                }
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
        }
    }
}

struct MyFridgeView_Previews: PreviewProvider {
    static var previews: some View {
        MyFridgeView()
    }
}
