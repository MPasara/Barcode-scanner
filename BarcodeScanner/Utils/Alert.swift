//
//  Alert.swift
//  BarcodeScanner
//
//  Created by Mladen Pašara on 19.06.2025..
//

import SwiftUI

struct AlertItem: Identifiable{
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct AlertContext{
    static let invalidDeviceInput = AlertItem(title: "Invalid Device Input", message: "Something wrong with camera. Unable to capture input", dismissButton: .default(Text("OK")))
    static let invalidScanType = AlertItem(title: "Invalid Scan Type", message: "Value scanned is not valid. This app scans EAN-8 and EAN-13 barcodes", dismissButton: .default(Text("OK")))
}
