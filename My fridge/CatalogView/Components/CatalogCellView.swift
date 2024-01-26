//
//  CatalogCellView.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct CatalogCellView: View {
    let title: String
    let imageUrl: String
    
    var body: some View {
        VStack {
            CatalogLogoImage(catalogLogoURL: imageUrl)
            Text(title)
                .foregroundColor(Color("BackgroundColor"))
                .multilineTextAlignment(.center)
                .lineLimit(1)
        }
    }
}

struct CatalogCellView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogCellView(title: "название категории", imageUrl: "hjj")
    }
}
