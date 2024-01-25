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
            HStack(alignment: .center) {
                ProductLogoImage(productLogoUrl: viewModel.productImageUrl)
                    .frame(width: 100, height: 100)
                VStack {
//                    Text(viewModel.productManufacturer)
                    Text(viewModel.productTitle)
                        .frame(height: 100)
                        .minimumScaleFactor(0.7)
                }
//                .frame(height: 100)
                Spacer()
                Text(String(format: "%.2f", viewModel.productRating))
                Image(systemName: "star.leadinghalf.filled")
                    .foregroundColor(.yellow)
            }
            .padding(.horizontal)
            .task {
                await viewModel.fetchPoductCard(id: viewModel.productId)
            }
            ProductInfoView(worth: viewModel.productWorth)
            ForEach(viewModel.criteriaRatings, id: \.self) {rating in
                CriteriaRatingView(criteriaRating: rating)
            }
//            Text(viewModel.productDescription).minimumScaleFactor(0.7)
            
//            ForEach(viewModel.productInfoStats.sorted(by: { $0.key < $1.key }), id: \.key) { (name, info) in
//                ProductInfoView(name: name, info: info)
//            }
//            .padding(8.0)
//            ProductInfoView(name: viewModel.productInfoName, info: viewModel.productInfoInfo)
//            Text(viewModel.productCard?.description ?? "sfs")
            Spacer()
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(viewModel: ProductViewModel(product: Product(id: 10, title: "dfgdfgdgdfg", totalRating: 2.0, manufacturer: "dgdfgdfgd", thumbnail: "", hasQualityMark: true, categoryName: "", hasBadQualityMark: true)))
    }
}
