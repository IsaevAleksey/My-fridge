//
//  ProductView.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct ProductView: View {
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
        ProductView()
    }
}
