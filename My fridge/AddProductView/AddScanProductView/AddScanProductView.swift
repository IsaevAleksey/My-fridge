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

    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                ProductLogoImage(productLogoUrl: viewModel.productImageUrl)
                    .frame(width: 100, height: 100)
                VStack {
//                    Text(viewModel.productManufacturer)
                    Text(viewModel.productTitle)
                        .frame(height: 100)
                        .minimumScaleFactor(0.7)
                }
//                .frame(height: 100)
                Spacer()
                Text(String(format: "%.2f", viewModel.productRating))
                Image(systemName: "star.leadinghalf.filled")
                    .foregroundColor(.yellow)
            }
            .padding([.leading, .bottom, .trailing])
            .task {
                await viewModel.fetchPoductCardForBarcode(barcode: "")
            }
            ScrollView {
                ProductInfoView(worth: viewModel.productWorth)
                ForEach(viewModel.criteriaRatings, id: \.self) { rating in
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
            .padding(.vertical)
            Spacer()
            Button {
//                viewModel.addProduct(title: viewModel.productName, manufacturer: viewModel.productManufactured)
                guard let product = viewModel.productCard else { return }
                myFridgeViewModel.addScanProduct(product: product)
                dismiss()
//                dismiss()
            } label: {
                Text("Добавить")
                    .frame(width: 200,height: 35)
                    .background(Color("BackgroundColor"))
//                    .background(viewModel.productName.isEmpty ? Color(.systemGray4) : Color("BackgroundColor"))
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
            }
//            .disabled(viewModel.productName.isEmpty)
//            Button {
//                guard let productCard = viewModel.productCard else {return}
//                StorageManager.shared.addProduct(productCard: productCard)
//            } label: {
//                Text("Добавить")
//                    .frame(width: 200,height: 35)
//                    .background(Color("BackgroundColor"))
//                    .foregroundColor(Color.white)
//                    .cornerRadius(20)
//                    .shadow(radius: 10)
//            }
        }
    }
}

struct AddScanProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddScanProductView(viewModel: AddScanProductViewModel())
    }
}
