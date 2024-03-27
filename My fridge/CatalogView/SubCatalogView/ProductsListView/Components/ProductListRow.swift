//
//  ProductListRow.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct ProductListRow: View {
    let title: String
    let imageUrl: String
    let productRating: Double
    let productManufacturer: String

    var body: some View {
        HStack {
            ProductLogoImage(productLogoUrl: imageUrl)
                .frame(width: 50, height: 50)
            VStack {
                Text(title)
                Text(productManufacturer) // не переносить больше двух строк?
            }
            Spacer()
            HStack {
                Text(String(format: "%.2f", productRating))
                Image(systemName: "star.leadinghalf.filled")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct ProductListRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductListRow(title: "тайтл", imageUrl: "", productRating: 4.53, productManufacturer: "производитель")
    }
}
