//
//  ProductLogoImage.swift
//  My fridge
//
//  Created by Алексей Исаев on 05.12.2023.
//

import SwiftUI

struct ProductLogoImage: View {
    let productLogoUrl: String
    
    var body: some View {
        CacheAsyncImage(imageURL: productLogoUrl) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(10)
            case .empty:
                Image(systemName: "xmark.shield")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
            case .failure:
                Image(systemName: "xmark.shield")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
            @unknown default:
                Image(systemName: "xmark.shield")
                    .frame(width: 50, height: 50)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
            }
        }
    }
}

struct ProductLogoImage_Previews: PreviewProvider {
    static var previews: some View {
        ProductLogoImage(productLogoUrl: "")
    }
}
