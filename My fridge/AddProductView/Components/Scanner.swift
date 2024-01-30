//
//  Scanner.swift
//  My fridge
//
//  Created by Алексей Исаев on 30.01.2024.
//

import SwiftUI
import AVFoundation

struct Scanner: UIViewControllerRepresentable {
    @Binding var scannedCode: String?
    
    class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        var parent: Scanner
        
        init(parent: Scanner) {
            self.parent = parent
        }
        
        func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
            if let metadataObject = metadataObjects.first {
                guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
                guard let stringValue = readableObject.stringValue else { return }
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                NotificationCenter.default.post(name: .scannedCodeReceived, object: stringValue)
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        
        let session = AVCaptureSession()
        
        guard let device = AVCaptureDevice.default(for: .video) else { return viewController }
        guard let input = try? AVCaptureDeviceInput(device: device) else { return viewController }
        
        session.addInput(input)
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(context.coordinator, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.ean8, .ean13, .pdf417] // Укажите типы штрих-кодов, которые вы хотите сканировать
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = viewController.view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)
        
        DispatchQueue.global().async {
            session.startRunning()
        }
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

extension Notification.Name {
    static let scannedCodeReceived = Notification.Name("ScannedCodeReceived")
}

struct Scanner_Previews: PreviewProvider {
    static var previews: some View {
        Scanner(scannedCode: .constant("123"))
    }
}
