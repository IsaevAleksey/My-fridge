//
//  ScannerView.swift
//  My fridge
//
//  Created by Алексей Исаев on 30.01.2024.
//

import SwiftUI
import AVFoundation

struct ScannerView: View {
    @Binding var scannedCode: String?
    @Binding var isShowingAddScanProductView: Bool
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Scanner(scannedCode: $scannedCode)
                .alert(isPresented: $isShowingAlert) {
                    Alert(title: Text("Ошибка"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
        }
        .onReceive(NotificationCenter.default.publisher(for: .scannedCodeReceived)) { notification in
            if let code = notification.object as? String {
                self.scannedCode = code
                isShowingAddScanProductView = true
            } else {
                self.alertMessage = "Неправильный формат штрихкода"
                self.isShowingAlert = true
            }
        }
    }
}

struct ScannerView_Previews: PreviewProvider {

    static var previews: some View {
        ScannerView(scannedCode: .constant("String"), isShowingAddScanProductView: .constant(true))
    }
}
