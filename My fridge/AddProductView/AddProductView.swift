//
//  AddProduct.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct AddProductView: View {
    @State private var date = Date()
    @State private var scannedCode: String?
    @State private var isShowingAddScanProductView = false
    @EnvironmentObject var viewModel: MyFridgeViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Добавить продукт")
                    .font(.largeTitle).bold().padding(.vertical)
                if let scannedCode = scannedCode {
                    Text("Штрихкод отсканирован: \(scannedCode). Нажмите Далее")
                        .multilineTextAlignment(.center)
                } else {
                    Text("Отсканируйте штрихкод для поиска в базе Роскачества")
                        .multilineTextAlignment(.center)
                }
                Spacer()
                VStack {
                    ScannerView(scannedCode: $scannedCode, isShowingAddScanProductView: $isShowingAddScanProductView)
    //                    .clipShape(RoundedRectangle(cornerRadius: 20))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .frame(maxWidth: 350, maxHeight: 400)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke())
                }
                Spacer()
                HStack {
                    NavigationLink {
                        AddProductManualView(viewModel: AddProductManualViewModel())
                    } label: {
                        Text("Добавить вручную")
                            .frame(width: 170,height: 40)
                            .background(Color("BackgroundColor"))
                            .foregroundColor(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    }
                    NavigationLink {
                        AddScanProductView(viewModel: AddScanProductViewModel(), scannedBarcode: scannedCode ?? "")
                    } label: {
                        Text("Далее")
                            .frame(width: 170,height: 40)
                            .background(!isShowingAddScanProductView ? Color(.systemGray4) : Color("BackgroundColor"))
                            .foregroundColor(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    }
                    .disabled(!isShowingAddScanProductView)
                }
            }
        }
        .accentColor(Color("TextColor"))
    }
}

struct AddProduct_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
