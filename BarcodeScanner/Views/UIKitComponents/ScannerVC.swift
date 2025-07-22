//
//  ScannerVC.swift
//  BarcodeScanner
//
//  Created by Mladen Pašara on 17.06.2025..
//

import AVFoundation
import UIKit

enum CameraError{
    case invalidDevice
    case invalidScanValue
}

protocol ScannerVCDelegate: AnyObject{
    func didFind(barcode: String)
    func didSurface(error: CameraError)
}

final class ScannerVC: UIViewController {
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: ScannerVCDelegate?
    
    init(scannerDelegate: ScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let previewLayer = previewLayer else {
            scannerDelegate?.didSurface(error: .invalidDevice)
            return
        }
        
        previewLayer.frame = view.layer.bounds
    }
    
    private func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else{
            scannerDelegate?.didSurface(error: .invalidDevice)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
            
        } catch{
            scannerDelegate?.didSurface(error: .invalidDevice)
            return
        }
        
        if captureSession.canAddInput(videoInput){
            captureSession.addInput(videoInput)
        }else{
            scannerDelegate?.didSurface(error: .invalidDevice)
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput){
            captureSession.addOutput(metaDataOutput)
            
            metaDataOutput.setMetadataObjectsDelegate(self, queue: .main)
            metaDataOutput.metadataObjectTypes = [.ean8]
        }else{
            scannerDelegate?.didSurface(error: .invalidDevice)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer!.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
    }
}

extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        guard let object = metadataObjects.first else{
            scannerDelegate?.didSurface(error: .invalidScanValue)
            return
        }
        guard let machineReadableCodeObject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDelegate?.didSurface(error: .invalidScanValue)
            return
        }
        
        guard let barcode = machineReadableCodeObject.stringValue else {
            scannerDelegate?.didSurface(error: .invalidScanValue)
            return
        }
        
        captureSession.stopRunning()
        scannerDelegate?.didFind(barcode: barcode)
    }
 }

