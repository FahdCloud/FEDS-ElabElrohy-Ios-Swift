//
//  CustomRadioButton.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 30/03/2024.
//

import SwiftUI

struct CustomRadioButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    let isDark = UserDefaultss().restoreBool(key: "isDark")

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: isSelected ? "largecircle.fill.circle" : "circle")
                Text(text)
                    .font(
                        Font.custom(Fonts().getFontLight(), size: 16)
                            .weight(.light)
                    )
                    .lineSpacing(5)
                    .foregroundColor(isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
            }
        }
        .foregroundColor(isSelected ? .blue : .primary)
    }
}
