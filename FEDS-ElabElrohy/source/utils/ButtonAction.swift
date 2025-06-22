//
//  ButtonAction.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 30/03/2024.
//

import SwiftUI


struct ButtonAction: View {
    var isWithIcon: Bool = false
    var iconName: String = ""
    var text: String
    var textSize: CGFloat = 24
    var color: Color
    var onClick: (() -> Void)?
    
    var body: some View {
        
        
        Button {
            onClick?()
        } label: {
            HStack(spacing: 4) {
                if isWithIcon {
                    Image(iconName)
                        .resizable()
                        .frame(width: 40,height: 40)
                }
                
                Text(text)
                    .font(
                        Font.custom(Fonts().getFontBold(), size: textSize)
                            .weight(.bold)
                    )
            }
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(color)
            .cornerRadius(10)
        }
        
        
    }
}
