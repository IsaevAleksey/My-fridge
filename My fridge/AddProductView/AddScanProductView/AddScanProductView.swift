//
//  AddScanProductView.swift
//  My fridge
//
//  Created by Алексей Исаев on 22.02.2024.
//

import SwiftUI

struct AddScanProductView: View {
    @StateObject var viewModel: AddScanProductViewModel
    @EnvironmentObject var myFridgeViewModel: MyFridgeViewModel
    
    @Environment(\.dismiss) private var dismiss

    let scannedBarcode: String
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                Spacer()
                ProgressView("Поиск продукта...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                Spacer()
            } else if viewModel.notFoundError {
                Spacer()
                Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: 50))
                    .foregroundColor(.orange)
                    .padding(.bottom)
                Text("Продукт не найден. Попробуйте отсканировать другой штрихкод или добавьте продукт вручную.")
                    .multilineTextAlignment(.center)
                    .padding()
                AddProductManualView(viewModel: AddProductManualViewModel(), myFridgeViewModel: _myFridgeViewModel)
                Spacer()
            } else if viewModel.productCard == nil {
                Text("К сожалению, продукт не найден. Для добавления продукта, пожалуйста, заполните форму ниже.")
                    .multilineTextAlignment(.center)
                    .padding(.top)
                AddProductManualView(viewModel: AddProductManualViewModel(), myFridgeViewModel: _myFridgeViewModel)
            } else {
                HStack(alignment: .center) {
                    ProductLogoImage(productLogoUrl: viewModel.productImageUrl)
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text(viewModel.productTitle)
                            .bold()
//                            .frame(height: 100)
                            .minimumScaleFactor(0.7)
                        Text(viewModel.productManufacturer)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top)
                    Spacer()
                    if viewModel.productRating != 0 {
                        Text(String(format: "%.2f", viewModel.productRating))
                        Image(systemName: "star.leadinghalf.filled")
                            .foregroundColor(.yellow)
                    }
                }
                .padding([.leading, .bottom, .trailing])
                ScrollView {
                    ProductInfoView(worth: viewModel.productWorth)
                    ForEach(viewModel.criteriaRatings, id: \ .self) { rating in
                        CriteriaRatingView(criteriaRating: rating)
                    }
                }
                Spacer()
                Text("Укажите срок годности продукта")
                DatePicker(
                    "Срок годности до:",
                    selection: $viewModel.expirationDate,
                    displayedComponents: [.date]
                )
                .environment(\.locale, Locale(identifier: "ru_RU"))
                .padding(.all)
                Spacer()
                Button {
                    guard let product = viewModel.productCard else { return }
                    let updatedProduct = ProductCard(
                        id: product.id,
                        apiId: product.apiId,
                        title: product.title,
                        totalRating: product.totalRating,
                        description: product.description,
                        categoryName: product.categoryName,
                        manufacturer: product.manufacturer,
                        worth: product.worth,
                        criteriaRatings: product.criteriaRatings,
                        thumbnail: product.thumbnail,
                        expirationDate: viewModel.expirationDate,
                        expirationDateString: viewModel.expirationDateString
                    )
                    myFridgeViewModel.addScanProduct(product: updatedProduct)
                    dismiss()
                    dismiss()
                } label: {
                    Text("Добавить продукт")
                        .frame(width: 200, height: 40)
                        .background(Color("BackgroundColor"))
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            print("=== AddScanProductView body построен, scannedBarcode: \(scannedBarcode) ===")
        }
        .task {
            print("=== .task вызван, scannedBarcode: \(scannedBarcode) ===")
            await viewModel.fetchPoductCardForBarcode(barcode: scannedBarcode)
        }
    }
}

struct AddScanProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddScanProductView(viewModel: AddScanProductViewModel(), scannedBarcode: "4600605033906")
    }
}
