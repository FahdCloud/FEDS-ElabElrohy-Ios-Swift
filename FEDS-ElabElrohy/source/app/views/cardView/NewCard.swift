//
//  NewsCardView.swift
//  FPLS-Dev
//
//  Created by Mrwan on 15/11/2023.
//


import SwiftUI

struct NewCard: View {
    
    let imageUrl : String
    let nameTitle : String
    
    let isDark = UserDefaultss().restoreBool(key: "isDark")
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            ZStack{
                ZStack{
                    CustomImageUrl(url: imageUrl,width: .infinity,height: .infinity)
                        .disabled(true)
                }
                .background(isDark ? .black : .white)
                .cornerRadius(12)

                HStack(spacing:40) {
                    VStack{
                        Text(nameTitle)
                            .font(
                                Font.custom(Fonts().arabic_gess_bold, size: 20)
                                    .weight(.bold)
                            )
                            .padding(.horizontal, 5)
                            .padding(.vertical, 6)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                            .frame(width: .infinity, height: .infinity, alignment: .center)
                    }
                    .frame(maxWidth:.infinity)
                    .frame(height:.infinity)
                    .background(isDark ? Color(Colors().darkCardBgText): Color(Colors().lightCardBgText))
                }
                .frame(maxHeight:.infinity , alignment:.bottom)
                .frame(width: 350)
            }
            .frame(width: 350,height: .infinity,alignment: .leading)
        }
        .padding(.trailing, 46)
        .frame(width: 350,height: 200, alignment: .leading)
        .background(isDark ? .black : .white)
        .cornerRadius(12)
        .shadow(color: isDark ? .white : .black.opacity(0.25), radius: 4, x: 0, y: 1)

    }
}


#Preview {
    CardBottomTxtWithBgImageUrl(imageUrl: "", nameTitle: "")
}
