//
//  ProductRow.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct ProductRow: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Название продукта")
                    .bold()
                Text("Производитель")
                HStack {
                    Text("Срок годности")
                        .fontWeight(.thin)
                    Text("10.11.2023")
                }
            }
            Spacer()
            Image(systemName: "xmark.shield")
                .resizable()
                .frame(width: 50, height:50)
        }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow()
    }
}
