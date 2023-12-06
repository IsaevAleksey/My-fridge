//
//  ProductInfo.swift
//  My fridge
//
//  Created by Алексей Исаев on 06.12.2023.
//

import SwiftUI

struct ProductInfoView: View {
    let name: [String]
    let info: [String]
    
    var body: some View {
        HStack {
            List(name, id: \.description) { nameInfo in
                Text(nameInfo)
            }
            List(info, id: \.description) { infoInfo in
                Text(infoInfo)
                }
        }
        
//        HStack {
//            Text(name)
//            Text(info)
//        }
    }
}

struct ProductInfo_Previews: PreviewProvider {
    static var previews: some View {
        ProductInfoView(name: ["String"], info: ["String"])
    }
}
