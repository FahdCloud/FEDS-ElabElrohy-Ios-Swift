//
//  CustomMenuAxisTab.swift
//  FEDS-BSQ
//
//  Created by Omar Pakr on 06/05/2024.
//

import SwiftUI
import AxisTabView


struct CustomMenuAxisTab<Content: View>: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()

    var tagAxisTab: Int
    var keyAxisTab: String
    var titleAxisTab: String
    var imageName: String
    var widthHstack: CGFloat = 85
    var heightHstack: CGFloat = 40
    var textSize: CGFloat = 15
    
    var pageView: () -> Content
    
    var body: some View {
       pageView()
            .tabItem(tag: tagAxisTab, normal: {
                CustomIcon(imageName: imageName)
            }, select: {
                HStack{
                   CustomIcon(imageName: imageName, width: 25, height: 25, darkColor: Color(Colors().darkMenuIconSelected), lightColor: Color(Colors().lightMenuIconSelected))
                                  
                    
                    Text(NSLocalizedString(titleAxisTab, comment: ""))
                        .bold()
                        .foregroundColor(genralVm.isDark ? Color(Colors().blackColorText): Color(Colors().whiteColorText))
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .font(
                            Font.custom(Fonts().getFontBold(), size: textSize)
                                .weight(.bold)
                        )
                        .onAppear(perform: {
                            UserDefaultss().saveInt(value: tagAxisTab, key: keyAxisTab)
                            
                        })
                }
                
                .frame(width: widthHstack,height: heightHstack)
                .padding(.horizontal,10)
                .padding(.vertical, 3)
                .background(genralVm.isDark ? Color(Colors().darkBtnMenu) : Color(Colors().lightBtnMenu))
                .cornerRadius(5)
            })
    }
}
