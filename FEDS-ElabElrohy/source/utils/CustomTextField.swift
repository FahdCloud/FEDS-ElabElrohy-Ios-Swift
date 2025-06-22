//
//  CustomTextFiled.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 06/04/2024.
//

import SwiftUI


struct CustomTextField: TextFieldStyle {
    let placeholder: String
    let textColor: Color
    let placeholderColor: Color
    let placeholderBgColor: Color
    let image: String
    var isEditing: Bool = false
   let isDark = UserDefaultss().restoreBool(key: "isDark")
    
    func _body(configuration: TextField<_Label>) -> some View {
        
        ZStack (alignment: .leading) {
            
            HStack{
                Image(image)
                    .resizable()
                    .frame(width: 25,height: 25)
                
                ZStack(alignment: .leading){
                    Text(placeholder)
                        .font(
                          Font.custom(Fonts().getFontLight(), size: 16)
                            .weight(.bold)
                        )
                        .foregroundColor(placeholderColor)
                        .padding(.horizontal, self.isEditing ? 10 : 0)
                        .background(placeholderBgColor) // the bg color of text when it placed between border
                        .offset(y: self.isEditing ? -28 : 0)
                        .scaleEffect(self.isEditing ? 0.9 : 1, anchor: .leading)
                    
                    configuration
                        .font(Font.custom(Fonts().getFontBold(), size: 18).weight(.bold))
                        .foregroundColor(textColor)
                    
                 
                }
                
                
              
            }
        }
        .animation(.easeOut, value: isEditing)
        .padding(.horizontal)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(self.isEditing ? placeholderColor : placeholderColor, lineWidth: 2)
        )
    }
}
