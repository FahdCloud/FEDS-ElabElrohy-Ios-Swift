//
//  MenuItem.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 26/03/2024.
//

import SwiftUI

struct MenuItem: View {
    var title: String
    var icon: String
    var width : CGFloat = 40
    var height : CGFloat = 40
    var cornerRadius : CGFloat = 20
    var fontSize : CGFloat = 20
    var bgColor : Color
    let constants = Constants()
    @State  var lang = Locale.current.language.languageCode!.identifier
    
    var body: some View {
        HStack {
            Image(icon)
                .resizable()
                .frame(width: width, height: height)
                .padding(.horizontal, 10)
            
            Spacer()
            
            Text(title)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(
                    Font.custom(Fonts().getFontBold(), size: fontSize).weight(.bold))
                .foregroundColor(Color.white)
            
            Spacer()
            
            if self.lang == constants.APP_IOS_LANGUAGE_AR  {
                Image("arrow_white_left")
                    .resizable()
                    .frame(width: width/2,height: height/2)
                    .padding(.horizontal, 20)
            }else {
                Image("arrow_white_right")
                    .resizable()
                    .frame(width: width/2,height: height/2)
                    .padding(.horizontal, 20)
            }
            
        }
        .padding(.vertical, 15)
        .background(bgColor)
        .cornerRadius(cornerRadius)
        
    }
}
