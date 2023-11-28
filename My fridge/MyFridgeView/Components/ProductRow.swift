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
            Text("Название продукта")
                .multilineTextAlignment(.leading)
            Spacer()
            VStack {
                Text("Срок годности")
                    .fontWeight(.thin)
                Text("10.11.2023")
            }
        }
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow()
    }
}
