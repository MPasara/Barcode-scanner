# 📱 SwiftUI Barcode Scanner

A lightweight, single-screen iOS app built with SwiftUI and UIKit integration that scans barcodes using the device's camera and displays the scanned value on screen. Powered by `AVCaptureSession`, it provides real-time scanning with clean error handling and SwiftUI alerts for a smooth user experience.

---

## 📚 Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [SwiftUI & UIKit Integration](#swiftui--uikit-integration)
- [Error Handling & UX](#error-handling--ux)
- [License](#license)

---

# Features

- 📷 Barcode scanning using `AVCaptureSession`
- 🧩 UIKit integration into SwiftUI
- ✅ EAN-8 barcode support (can be expanded)
- ⚠️ Real-time error feedback with SwiftUI alerts
- 🔒 Requires real device (camera not available on simulator)

---

## Requirements

- iOS 15.0+
- Xcode 13+
- Swift 5+

---

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/swiftui-barcode-scanner.git
   cd swiftui-barcode-scanner
   ```

2. Open the project in Xcode:
   ```bash
   open BarcodeScanner.xcodeproj
   ```

3. Build and run on a real device (barcode scanning requires camera access).

---

# Usage

1. Open the app.
2. Grant camera permission if prompted.
3. Point the camera at an EAN-8 barcode.
4. The scanned barcode value will be printed on screen.

---

# SwiftUI & UIKit Integration

This app uses `UIViewControllerRepresentable` to bring UIKit's `AVCaptureSession` into the SwiftUI hierarchy for barcode scanning.

# Key Components:

**ScannerVC.swift**
- Manages camera input, output, preview layer, and barcode detection using `AVCaptureMetadataOutputObjectsDelegate`.

**ScannerVCDelegate**
- A protocol for communicating scan results and errors from UIKit to SwiftUI.

**ScannerView.swift**
- A SwiftUI wrapper that embeds `ScannerVC` using `UIViewControllerRepresentable`.

---

# Error Handling & UX

The app uses a `CameraError` enum and delegate callbacks to handle:

- ❌ Camera device not available
- ❌ Failed to add camera input/output
- ❌ Invalid or unreadable barcode

These errors are surfaced to the user via SwiftUI alerts for better UX and transparency.

---

# License

This project is licensed under the MIT License. See the LICENSE file for more information.
