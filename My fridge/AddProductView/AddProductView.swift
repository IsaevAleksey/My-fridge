//
//  AddProduct.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct AddProductView: View {
    @State var showAddProductManualView = false
    @State private var date = Date()
    @State private var scannedCode: String?
    @State private var isShowingScanner = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Добавить продукт")
                    .font(.largeTitle).bold()
                VStack {
                    if let scannedCode = scannedCode {
                        Text("Scanned Code: \(scannedCode)")
                    } else {
                        Button("Scan Barcode") {
                            self.isShowingScanner = true
                        }
                    }
                }
                .sheet(isPresented: $isShowingScanner) {
                    ScannerView(scannedCode: self.$scannedCode)
                }
                Spacer()
                ScannerView(scannedCode: self.$scannedCode)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke())

//                    .border(Color("BackgroundColor"))
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                Text("Штрихкод")
                DatePicker(
                    "Срок годности до",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .environment(\.locale, Locale(identifier: "ru_RU"))
                .padding(.vertical)
                NavigationLink {
                    AddProductManualView(viewModel: AddProductManualViewModel())
                } label: {
                    Text("Добавить вручную")
                        .frame(width: 200,height: 35)
                        .background(Color("BackgroundColor"))
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                }
            }
//            .navigationTitle("Добавить продукт")
            .padding()
        }
    }
}

struct AddProduct_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
