//
//  ProductRow.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct ProductRow: View {
    var productTitle: String
    var manufacturer: String
    var productImageUrl: String
    var expirationDate: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(productTitle)
                    .bold()
                Text(manufacturer)
                HStack {
                    Text("Срок годности")
                        .fontWeight(.thin)
                    Text(expirationDate)
                }
            }
            Spacer()
            ProductLogoImage(productLogoUrl: productImageUrl)
                .frame(width: 50, height: 50)
        }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(productTitle: "Название продукта", manufacturer: "Производитель", productImageUrl: "", expirationDate: "")
    }
}
