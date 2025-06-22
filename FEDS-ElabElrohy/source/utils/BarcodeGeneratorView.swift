//
//  BarcodeGeneratorView.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 27/03/2024.
//

import SwiftUI


struct BarcodeGeneratorView: UIViewRepresentable {
    let barcodeString: String
    
    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = generateBarcode(code: barcodeString)
        return imageView
    }
    
    func updateUIView(_ uiView: UIImageView, context: Context) {
        // Update the view if needed
    }
    
    func generateBarcode(code: String) -> UIImage? {
        let isDark = UserDefaultss().restoreBool(key: "isDark")

        let data = code.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            let customColor = UIColor(hex: Colors().financeColor) // Example of a custom color in hex
            if let output = filter.outputImage?.transformed(by: transform) {
                let colorParameters = [
                    "inputColor0": CIColor(color: isDark ? UIColor.white : UIColor.black), // Barcode color
                    "inputColor1": CIColor(color: .clear) // Background color
                ]
                let colored = output.applyingFilter("CIFalseColor", parameters: colorParameters)
                
                let context = CIContext()
                if let cgImage = context.createCGImage(colored, from: colored.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }
        }
        
        return nil
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)

        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }

        var color: UInt64 = 0
        scanner.scanHexInt64(&color)

        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask

        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}

