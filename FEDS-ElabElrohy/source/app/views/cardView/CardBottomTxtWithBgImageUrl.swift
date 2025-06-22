//
//  NewsCardView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 15/11/2023.
//


import SwiftUI

struct CardBottomTxtWithBgImageUrl: View {
    
    var width: CGFloat = UIScreen.main.bounds.width-50
    var height: CGFloat = 220
    var defaultImage: String = "picture"
    let imageUrl: String
    let nameTitle: String
    var nameTitleSize: CGFloat = 20
  
    let isDark = UserDefaultss().restoreBool(key: "isDark")
    var onClick: (() -> Void)?
   
    // Define custom padding values
    let customHorizontalPadding: CGFloat = 20 // Adjust the padding as you like

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
            
                CustomImageUrl(defaultImage: defaultImage, url: imageUrl, width: width,
                               height: height){
                    self.onClick?()
                }
                    .clipped()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 220)
                
                Text(nameTitle)
                    .font(Font.custom(Fonts().getFontBold(), size: nameTitleSize))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .foregroundColor(isDark ? Color(Colors().darkCardText) : Color(Colors().lightCardText))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity)
                    .background(isDark ? Color(Colors().darkCardBgText) : Color(Colors().lightCardBgText))
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
           }
        .onTapGesture {
            self.onClick?()
        }
    
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: isDark ? .white : .black.opacity(0.25), radius: 4, x: 0, y: 10)
        .padding()
        .frame(height: 220)
    }
}
