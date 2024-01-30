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
//                Text("Добавить продукт")
//                    .font(.largeTitle)
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
                Text("Штрихкод")
                Spacer()
                DatePicker(
                    "Срок годности до",
                    selection: $date,
                    displayedComponents: [.date]
                )
                NavigationLink {
                    AddProductManualView()
                } label: {
                    Text("Добавить вручную")
                        .frame(width: 200,height: 35)
                        .background(Color("BackgroundColor"))
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                }
            }
            .navigationTitle("Добавить продукт")
            .padding()
        }
    }
}

struct AddProduct_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
