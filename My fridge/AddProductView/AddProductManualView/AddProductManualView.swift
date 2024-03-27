//
//  AddProductManualView.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct AddProductManualView: View {
    @StateObject var viewModel: AddProductManualViewModel
    @EnvironmentObject var myFridgeViewModel: MyFridgeViewModel
//    @Environment(\.presentationMode) var presentationMode

//    @State private var date = Date()


    @Environment(\.dismiss) private var dismiss

//    @State private var date = Date()
//    @State private var productName: String = ""
//    @State private var productManufactured: String = ""
    
    var body: some View {
        VStack {
            Text("Название продукта")
                .bold()
            TextField("Название продукта", text: $viewModel.productName, prompt: Text("Введите название продукта"))
                .frame(height: 40)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
            Text("Производитель")
                .bold()
                .padding(.top)
            TextField("Производитель", text: $viewModel.productManufactured, prompt: Text("Введите производителя"))
                .frame(height: 40)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
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
                myFridgeViewModel.addProductManual(title: viewModel.productName, manufacturer: viewModel.productManufactured, expirationDate: viewModel.expirationDate, expirationDateString: viewModel.expirationDateString)
                dismiss()
            } label: {
                Text("Добавить")
                    .frame(width: 200,height: 40)
                    .background(viewModel.productName.isEmpty ? Color(.systemGray4) : Color("BackgroundColor"))
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
            }
            .disabled(viewModel.productName.isEmpty)
        }
        .padding()
    }
}

struct AddProductManualView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductManualView(viewModel: AddProductManualViewModel())
    }
}
