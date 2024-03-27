//
//  SubCatalogView.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct SubCatalogView: View {
    @StateObject var viewModel: SubCatalogViewModel
    
    private let column = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: column) {
                ForEach(viewModel.rows, id: \.productGroupId) {productListViewModel in
                    NavigationLink(destination: ProductsListView(viewModel: productListViewModel), label: {
                        CatalogCellView(title: productListViewModel.productGroupTitle, imageUrl: productListViewModel.productGroupImageUrl)
                    })
                }
            }
            .navigationTitle(viewModel.categoryTitle)
        }
        .padding()
        .task {
            await viewModel.fetchSubCategoriesList(id: viewModel.categoryId)
            print(viewModel.categoryId)
        }
    }
}

struct SubCatalogView_Previews: PreviewProvider {
    static var previews: some View {
        SubCatalogView(viewModel: SubCatalogViewModel(category: Category(id: 5, title: "", icon: "", thumbnail: "String")))
    }
}
