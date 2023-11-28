//
//  CatalogCellView.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct CatalogCellView: View {
    var body: some View {
        VStack {
            Image(systemName: "carrot")
                .resizable()
                .frame(width: 150, height: 150)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 4))
            Text("Название категории")
        }
    }
}

struct CatalogCellView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogCellView()
    }
}
