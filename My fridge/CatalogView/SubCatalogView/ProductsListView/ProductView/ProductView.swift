//
//  ProductView.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct ProductView: View {
    @StateObject var viewModel: ProductViewModel
    var body: some View {
        VStack {
            HStack {
                ProductLogoImage(productLogoUrl: viewModel.productImageUrl)
                    .frame(width: 100, height: 100)
                VStack {
                    Text(viewModel.productManufacturer)
                    Text(viewModel.productTitle)
                }
                Spacer()
                Text(String(format: "%.2f", viewModel.productRating))
                Image(systemName: "star.leadinghalf.filled")
                    .foregroundColor(.yellow)
                
            }
            ProductInfoView(name: viewModel.productInfoName, info: viewModel.productInfoInfo)
//            Text(viewModel.productCard?.description ?? "sfs")
            Spacer()
        }
        .task {
            await viewModel.fetchPoductCard(id: viewModel.productId)
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(viewModel: ProductViewModel(product: Product(id: 10, title: "dfgdfgdgdfg", totalRating: 2.0, manufacturer: "dgdfgdfgd", thumbnail: "", hasQualityMark: true, categoryName: "", hasBadQualityMark: true)))
    }
}
