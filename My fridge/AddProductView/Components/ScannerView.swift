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
    @State private var isShowingAlert = false
    @State private var alertMessage = ""
    
    
    var body: some View {
        VStack {
            Scanner(scannedCode: $scannedCode)
                .alert(isPresented: $isShowingAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
        }
        .onReceive(NotificationCenter.default.publisher(for: .scannedCodeReceived)) { notification in
            if let code = notification.object as? String {
                self.scannedCode = code
                // Здесь можно добавить логику для отправки на сервер
            } else {
                self.alertMessage = "Invalid barcode format"
                self.isShowingAlert = true
            }
        }
    }
}

struct ScannerView_Previews: PreviewProvider {

    static var previews: some View {
        ScannerView(scannedCode: .constant("String"))
    }
}
