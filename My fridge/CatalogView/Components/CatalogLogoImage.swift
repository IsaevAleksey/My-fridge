//
//  CatalogLogoImage.swift
//  My fridge
//
//  Created by Алексей Исаев on 04.12.2023.
//

import SwiftUI

struct CatalogLogoImage: View {
    let catalogLogoURL: String

    var body: some View {
        CacheAsyncImage(imageURL: catalogLogoURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .cornerRadius(10)
            case .empty:
                ProgressView()
                    .frame(width: 150, height: 120)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
            case .failure:
                Image(systemName: "xmark.shield")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
            @unknown default:
                Image(systemName: "xmark.shield")
                    .frame(width: 120, height: 120)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
            }
        }
    }
}

struct CatalogLogoImage_Previews: PreviewProvider {
    static var previews: some View {
        CatalogLogoImage(catalogLogoURL: "asdasd")
    }
}
