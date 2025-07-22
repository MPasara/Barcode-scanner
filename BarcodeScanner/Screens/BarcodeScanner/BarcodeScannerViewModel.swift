//
//  BarcodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by Mladen Pašara on 19.06.2025..
//

import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    @Published var scannedBarcode = ""
    @Published var alertItem: AlertItem?
    
    var statusText: String {
        scannedBarcode.isEmpty ? "No barcode found" : scannedBarcode
    }
    
    var statusTextColor: Color{
        scannedBarcode.isEmpty ? .red : .green
    }
}
