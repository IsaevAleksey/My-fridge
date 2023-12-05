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
            Text("Название продукта")
                .font(.largeTitle)
            Spacer()
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 100, height: 100)
            Text("Многа букав")
            Spacer()
        }
        .padding()
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(viewModel: ProductViewModel(product: Product(id: 10, title: "", totalRating: 2.0, manufacturer: "", thumbnail: "", hasQualityMark: true, categoryName: "", hasBadQualityMark: true)))
    }
}
