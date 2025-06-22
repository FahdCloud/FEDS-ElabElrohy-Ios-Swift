//
//  CardView.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 06/03/2024.
//

import SwiftUI

struct CardBottomTxtWithBgImageAsset: View {
    
    let imageAsset : String
    let tittleOfCard : String
    let isDark = UserDefaultss().restoreBool(key: "isDark")
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            VStack (spacing: 15){
                GeometryReader { geometry in
                    ZStack (alignment: .bottom){
                        Image(imageAsset)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: .infinity, height: .infinity)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 10)
                        // Use a VStack with a background for the text
                        
                        HStack(spacing:40) {
                            VStack {
                                Text(tittleOfCard)
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 20)
                                            .weight(.bold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .lineLimit(1)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical,5)
                                    .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                    .frame(width: geometry.size.width, height: .infinity, alignment: .center)
                            }
                            .frame(maxWidth:.infinity)
                            .frame(height:.infinity)
                            .background(isDark ? Color(Colors().darkCardBgText): Color(Colors().lightCardBgText))
                        }
                        .frame(maxHeight:.infinity , alignment:.bottom)
                        .frame(width: geometry.size.width)
                    }
                    .frame(width: geometry.size.width)
                    .background(isDark ? Color(Colors().darkCardBgBlack): Color(Colors().lightCardBgWhite))
                    .cornerRadius(5)
                }
            }
        }
        .background(.gray)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 1)
    }
}



