//
//  CustomeTextFieldStyle.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 29/08/2023.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    let placeholder: String
    let placeholderColor: Color
    let placeholderBgColor: Color
    let image: String
    var isPassword : Bool
    var isEditing: Bool
   let isDark = UserDefaultss().restoreBool(key: "isDark")

   @Binding var isTapped : Bool
    
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
                        .foregroundColor(placeholderColor.opacity(0.5))
                        .padding(.horizontal, self.isEditing ? 10 : 0)
                        .background(placeholderBgColor) // the bg color of text when it placed between border
                        .offset(y: self.isEditing ? -28 : 0)
                        .scaleEffect(self.isEditing ? 0.9 : 1, anchor: .leading)
                    
                    configuration
                        .font(Font.custom(Fonts().getFontBold(), size: 18).weight(.bold))
                        .foregroundColor(placeholderColor)
                    
                 
                }
                
                if isPassword {
                    Spacer()
                    Image(systemName: isTapped ? "eye.slash" : "eye.fill")
                        .onTapGesture {
                            isTapped.toggle()
                    }
                }
                
              
            }
        }
        .animation(.easeOut, value: isEditing)
        .padding(.horizontal)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(self.isEditing ? placeholderColor : placeholderColor.opacity(0.2), lineWidth: 2)
        )
    }
}
