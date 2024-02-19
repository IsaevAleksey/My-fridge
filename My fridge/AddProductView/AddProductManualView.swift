//
//  AddProductManualView.swift
//  My fridge
//
//  Created by Алексей Исаев on 28.11.2023.
//

import SwiftUI

struct AddProductManualView: View {
    @State private var date = Date()
    @State private var productName: String = ""
    @State private var productManufactured: String = ""
    
    var body: some View {
        VStack {
            Text("Название продукта")
                .bold()
            TextField("Название продукта", text: $productName, prompt: Text("Введите название продукта"))
                .frame(height: 40)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
            Text("Производитель")
                .bold()
                .padding(.top)
            TextField("Производитель", text: $productManufactured, prompt: Text("Введите производителя"))
                .frame(height: 40)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke())
            DatePicker(
                "Срок годности до:",
                selection: $date,
                displayedComponents: [.date]
            )
            .padding(.vertical)
            Spacer()
            Text("Добавить продукт")
                .frame(width: 200,height: 35)
                .background(Color("BackgroundColor"))
                .foregroundColor(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
        }
        .padding()
    }
}

struct AddProductManualView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductManualView()
    }
}
