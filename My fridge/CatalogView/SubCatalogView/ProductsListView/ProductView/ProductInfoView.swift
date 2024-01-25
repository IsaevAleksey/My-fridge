//
//  ProductInfo.swift
//  My fridge
//
//  Created by Алексей Исаев on 06.12.2023.
//

import SwiftUI

struct ProductInfoView: View {
    let worth: [String]
    
    
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(worth, id: \.self) { parametr in
                HStack(alignment: .top) {
                    Image(systemName: "chevron.up.circle").foregroundColor(.green)
                    Text(parametr)
                }
            }
        }
        .padding(.horizontal, 6.0)
        .padding(.bottom)
    }
}

struct CriteriaRatingView: View {
    let criteriaRating: CriteriaRating

    var body: some View {
        HStack {
            Text(criteriaRating.title ?? "Unknown")
//                .font(.subheadline)
            Spacer()
            Text(String(format: "%.2f", criteriaRating.value ?? 0))

//            Text("\(criteriaRating.value ?? 0)")
//                .font(.subheadline)
        }
        .padding(.horizontal)
    }
}

struct ProductInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ProductInfoView(worth: ["String", "assfsdf", "werw"])
    }
}
