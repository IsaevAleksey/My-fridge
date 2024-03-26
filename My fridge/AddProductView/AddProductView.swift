//
//  AddProduct.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct AddProductView: View {
//    @State private var showAddProductManualView = false
    @State private var date = Date()
    @State private var scannedCode: String?
    @State private var isShowingAddScanProductView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Добавить продукт")
                    .font(.largeTitle).bold().padding(.bottom)
                if let scannedCode = scannedCode {
                    Text("Штрихкод отсканирован: \(scannedCode)")
                        .multilineTextAlignment(.center)
                } else {
                    Text("Отсканируйте штрихкод для поиска в базе Роскачества")
                        .multilineTextAlignment(.center)
                }
                Spacer()
                ScannerView(scannedCode: $scannedCode, isShowingAddScanProductView: $isShowingAddScanProductView)
                    .frame(maxWidth: 350, maxHeight: 400)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke())
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
                            .background(!isShowingAddScanProductView ? Color(.systemGray4) : Color("BackgroundColor"))                            .foregroundColor(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    }
                    .disabled(!isShowingAddScanProductView)
                }
            }
        }
        .accentColor(Color("BackgroundColor"))
        .preferredColorScheme(.light)
    }
    
    
//    var body: some View {
//        NavigationStack {
//            if isShowingAddScanProductView {
//                AddScanProductView(viewModel: AddScanProductViewModel(), scannedBarcode: scannedCode ?? "")
//            }
//            VStack {
//                Text("Добавить продукт")
//                    .font(.largeTitle).bold()
//                VStack {
//                    if let scannedCode = scannedCode {
//                        Text("Scanned Code: \(scannedCode)")
//                    }
////                    else {
////                        Button("Scan Barcode") {
////                            self.isShowingScanner = true
////                        }
////                    }
////                }
////                .sheet(isPresented: $isShowingScanner) {
////                    ScannerView(scannedCode: self.$scannedCode, isShowingNextView: $isShowingNextView)
//
//                }
//                Spacer()
//                ScannerView(scannedCode: self.$scannedCode, isShowingNextView: $isShowingAddScanProductView)
//                    .frame(maxWidth: .infinity, maxHeight: 400)
//
//                        .overlay(RoundedRectangle(cornerRadius: 20).stroke())
////                ScannerViewTwo()
//
////                    .border(Color("BackgroundColor"))
////                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                Spacer()
//                NavigationLink {
//                    AddProductManualView(viewModel: AddProductManualViewModel())
//                } label: {
//                    Text("Добавить вручную")
//                        .frame(width: 200,height: 35)
//                        .background(Color("BackgroundColor"))
//                        .foregroundColor(Color.white)
//                        .cornerRadius(20)
//                        .shadow(radius: 10)
//                }
//            }
////            .navigationTitle("Добавить продукт")
//            .padding()
//        }
//        .accentColor(Color("BackgroundColor"))
//    }
}

struct AddProduct_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
