//
//  LevelsCardView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 01/11/2023.
//

import SwiftUI

struct LevelsCardView: View {
    let levelName : String
    let numberOfVideos : String
    let levelLockStatus : Bool
    let showList : Bool
    let isDark = UserDefaultss().restoreBool(key: "isDark")

    var body: some View {
        VStack(alignment: .center) {
            HStack (spacing: 10){
                VStack {
                    Text(levelName)
                      .font(
                        Font.custom(Fonts().getFontBold(), size: 18)
                          .weight(.bold)
                      )
                      .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                      .multilineTextAlignment(.center)
                      .lineLimit(10)
                      .frame(alignment: .leading)
                      .padding(.leading, 10)
                
                }
              

                Spacer()
                
                Image( levelLockStatus ? "3d-lock" : "")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding()
                
               
                
                Image(systemName: showList ? "arrow.up" : "arrow.down")
                    .resizable()
                    .foregroundColor(isDark ? .white : .black)
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 10)
            }
            .frame(width: .infinity)
        }
        .frame(maxWidth:.infinity)
        .padding()
        .frame(width: .infinity, alignment: .center)
        .background(isDark ? Color(Colors().darkCardBgText): Color(Colors().lightCardBgText))
        .cornerRadius(12)
        .shadow(color: isDark ? .white : .black.opacity(0.25), radius: 4, x: 0, y: 3)
        }
}

#Preview {
    LevelsCardView(levelName: "", numberOfVideos: "", levelLockStatus: false,showList: true)
}
