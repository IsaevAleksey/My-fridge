//
//  ScannerViewModel.swift
//  My fridge
//
//  Created by Алексей Исаев on 16.03.2024.
//

import Foundation
import SwiftUI
import UIKit
import AVFoundation
import Vision

class ScannerViewModel: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    private let session = AVCaptureSession()
    private let seqHandler = VNSequenceRequestHandler()
    private var captureDevice = AVCaptureDevice.default(for: .video)
    private var request: VNDetectBarcodesRequest?
    
    @Published var scannedBarcode: String? // Штрих-код, обнаруженный при сканировании
    @Published var isCameraAuthorized = false // Флаг разрешения доступа к камере
    
    var previewLayer: AVCaptureVideoPreviewLayer?

//    override init() {
//        checkCameraAuthorization()
//        setUpScanner()
//    }
    
    func startScanning() {
        guard !session.isRunning else { return }
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }
    }
    
    func stopScanning() {
        guard session.isRunning else { return }
        turnLightOn(false)
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.stopRunning()
        }
    }
    
    func turnLightOn(_ on: Bool) {
        // Оставляем реализацию включения/выключения вспышки
        
    }
    
    func checkCameraAuthorization() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            DispatchQueue.main.async {
                self?.isCameraAuthorized = granted
            }
        }
    }
    
    func setUpScanner() {
        // Оставляем настройку сканера
        guard isCameraAuthorized else { return }
        captureDevice = AVCaptureDevice.default(for: .video)
        
        guard let captureDevice = captureDevice else { return }
        
        do {
            let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(deviceInput)
            
            let captureOutput = AVCaptureVideoDataOutput()
            captureOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
            captureOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: .userInitiated))
            session.addOutput(captureOutput)
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
            self.previewLayer = previewLayer
        } catch {
            print("Error setting up scanner: \(error.localizedDescription)")
        }
    }
    
    private func setUpSession() throws {
        // Оставляем настройку сессии захвата
    }
    
    func captureOutput(_: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from _: AVCaptureConnection) {
        // Оставляем обработку вывода семплов
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }

        guard let request = request else {
            return
        }
        try? seqHandler.perform([request], on: pixelBuffer)
    }
    
//    func sendBarcodeToServer(_ barcode: String) {
//        // Реализуем отправку штрих-кода на сервер
//        print("Sending barcode to server: \(barcode)")
//    }
}

struct ScannerViewTwo: View {
    @ObservedObject var viewModel = ScannerViewModel()
    @State private var isShowingNextView = false
    
    var body: some View {
        ZStack {
            if viewModel.isCameraAuthorized {
                if let previewLayer = viewModel.previewLayer {
                    // Отображение слоя предварительного просмотра или другого UI для сканирования
                    PreviewView(previewLayer: previewLayer)
                }
                
                if !isShowingNextView {
                    Button("Stop Scanning") {
                        viewModel.stopScanning()
                        isShowingNextView = true
                    }
                } else {
                    // Переход на другое представление после сканирования
                    AddScanProductView(viewModel: AddScanProductViewModel(), scannedBarcode: viewModel.scannedBarcode ?? "")
                }
            } else {
                Button("Grant Camera Access") {
                    viewModel.checkCameraAuthorization()
                }
//                или                 Text("Camera access is not authorized.")
            }
        }
        .onAppear {
            viewModel.checkCameraAuthorization()
            viewModel.setUpScanner()
            if viewModel.isCameraAuthorized {
                viewModel.startScanning()
            }
        }
        .onReceive(viewModel.$scannedBarcode) { barcode in
            if let barcode = barcode {
//                viewModel.sendBarcodeToServer(barcode)
                // Мы обнаружили штрих-код, поэтому переходим на другое представление
                isShowingNextView = true
            }
        }
    }
}

struct PreviewView: UIViewRepresentable {
    let previewLayer: AVCaptureVideoPreviewLayer
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        previewLayer.frame = view.layer.bounds
        view.layer.addSublayer(previewLayer)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        previewLayer.frame = uiView.layer.bounds
    }
}
