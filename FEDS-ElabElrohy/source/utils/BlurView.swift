//
//  BlurView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 25/10/2023.
//

import SwiftUI

struct BlurView : UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterial))
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
