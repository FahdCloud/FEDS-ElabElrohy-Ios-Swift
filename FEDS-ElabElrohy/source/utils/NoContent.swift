//
//  NoContent.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/09/2023.
//

import SwiftUI

struct NoContent: View {
    let isDark = UserDefaultss().restoreBool(key: "isDark")
    var message : String
    var image : String = "empty_data"
    
    var body: some View {
        VStack(alignment: .center){
            ScrollView{
                Image(image)
                    .resizable()
                    .frame(width: .infinity,height: 300)
                
                
                Text(message)
                    .font(
                        Font.custom(Fonts().getFontBold(), size: 18)
                            .weight(.bold))
                    .lineLimit(4)
                    .multilineTextAlignment(.center)
                    .foregroundColor(isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                .frame(width: .infinity, height: .infinity, alignment: .top)
                
                
            }
            .frame(width: .infinity, height: .infinity )
        }
        .padding()
    }
}

