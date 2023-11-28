//
//  CatalogView.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct CatalogView: View {
    private let column = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            LazyVGrid(columns: column) {
                CatalogCellView()
                CatalogCellView()
                CatalogCellView()
                CatalogCellView()

                
    //            ForEach(viewModel.prob.sorted(by: { $0.key < $1.key }), id: \.key) {
    //                (score, probability) in
    //                GridItemView(score: score, probability: probability)
    //            }
            }
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
