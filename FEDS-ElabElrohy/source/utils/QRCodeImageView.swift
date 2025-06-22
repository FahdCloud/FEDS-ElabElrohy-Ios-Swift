//
//  QRCodeImageView.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 27/03/2024.
//

import SwiftUI
import QRCode

struct QRCodeImageView: UIViewRepresentable {
    let theme: UIUserInterfaceStyle
    let code: String

    func makeUIView(context: Context) -> UIImageView {
        let uiImageView = UIImageView()
        generateQrCode(theme: theme, code: code, uIImage: uiImageView)
        return uiImageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        // Update the view if needed
    }

    func generateQrCode(theme: UIUserInterfaceStyle, code: String, uIImage: UIImageView) {
        generateQr(theme: theme, code: code, uIImage: uIImage)
    }
    
    func generateQr(theme : UIUserInterfaceStyle = .light, code :String, uIImage : UIImageView) {
        
       
        var qrCodeD = QRCode(string: code, size: CGSize(width: 300, height: 300))!
        
        if theme == .light {
            qrCodeD.color = UIColor.black
        } else if theme == .dark {
            qrCodeD.color = UIColor.white
           
        }
        qrCodeD.backgroundColor = UIColor(.clear)
        
        uIImage.image = try? qrCodeD.image()
        
    }
}
