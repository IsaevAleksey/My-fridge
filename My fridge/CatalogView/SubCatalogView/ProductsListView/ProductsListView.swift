//
//  ProductListView.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct ProductsListView: View {
    @StateObject var viewModel: ProductsListViewModel

    
    var body: some View {
            List(viewModel.rows, id: \.productId) { productViewModel in
                NavigationLink(destination: ProductView(viewModel: productViewModel)) {
                    ProductListRow(title: productViewModel.productTitle, imageUrl: productViewModel.productImageUrl, productRating: productViewModel.productRating, productManufacturer: productViewModel.productManufacturer)
                        .frame(height: 60)
                }
                .navigationTitle(viewModel.productGroupTitle)
            }
            .listStyle(.plain)
        .task {
            await viewModel.fetchProductsList(id: viewModel.productGroupId)
        }
    }
}

struct ProductsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsListView(viewModel: ProductsListViewModel(productGroup: ProductGroup(id: 5, title: "String", thumbnail: "String")))
    }
}
