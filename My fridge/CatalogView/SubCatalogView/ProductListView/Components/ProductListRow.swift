//
//  ProductListRow.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct ProductListRow: View {
    var body: some View {
        HStack {
            Image(systemName: "carrot")
                .resizable()
                .frame(width: 50, height: 50)
            VStack {
                Text("Название продукта")
                Text("Описание продукта, сначала что за продукт") // не переносить больше двух строк
            }
        }
    }
}

struct ProductListRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductListRow()
    }
}
