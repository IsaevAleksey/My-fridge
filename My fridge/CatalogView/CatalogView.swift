//
//  CatalogView.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct CatalogView: View {
    @StateObject var viewModel: CatalogViewModel

    private let column = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: column) {
                        ForEach(viewModel.rows, id: \.categoryId) {subCatalogViewModel in
                            NavigationLink(destination: SubCatalogView(viewModel: subCatalogViewModel), label: {
                                CatalogCellView(title: subCatalogViewModel.categoryTitle, imageUrl: subCatalogViewModel.categoryImageUrl)
                            })
                        }
                    }
                }
            }
            .navigationTitle("Каталог продуктов")
        }
        .padding()
        .task {
            await viewModel.fetchCategoriesList()
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView(viewModel: CatalogViewModel())
    }
}
