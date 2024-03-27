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
            ScrollView {
                HStack(alignment: .center) {
                    ProductLogoImage(productLogoUrl: viewModel.productImageUrl)
                        .frame(width: 100, height: 100)
                    VStack {
                        Text(viewModel.productTitle)
                            .frame(height: 100)
                            .minimumScaleFactor(0.7)
                    }
                    Spacer()
                    Text(String(format: "%.2f", viewModel.productRating))
                    Image(systemName: "star.leadinghalf.filled")
                        .foregroundColor(.yellow)
                }
                .padding([.leading, .bottom, .trailing])
                .task {
                    await viewModel.fetchPoductCard(id: viewModel.productId)
                }
                ProductInfoView(worth: viewModel.productWorth)
                ForEach(viewModel.criteriaRatings, id: \.self) {rating in
                    CriteriaRatingView(criteriaRating: rating)
                }
                Spacer()
            }
        }
        .padding(.top)
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(viewModel: ProductViewModel(product: Product(id: 10, title: "dfgdfgdgdfg1", totalRating: 2.0, manufacturer: "dgdfgdfgd2", thumbnail: "", hasQualityMark: true, categoryName: "", hasBadQualityMark: true)))
    }
}
