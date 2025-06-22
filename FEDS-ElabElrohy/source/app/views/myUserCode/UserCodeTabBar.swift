//
//  UserCodeTabBar.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 22/11/2023.
//


import SwiftUI


import AxisTabView

@available(iOS 16.0, *)
struct UserCodeTabBar: View {
    
    @State private var selection: Int = 0
    let isDark = UserDefaultss().restoreBool(key: "isDark")


    var body: some View {
        AxisTabView(selection: $selection, constant: ATConstant(axisMode: .bottom)) { state in
            ATMaterialStyle(state)
        } content: {
            
            MyUserCodeView(isQrCode: true)
                .tabItem(tag: 0, normal: {
                    HStack{
                        Text(NSLocalizedString("qrCode", comment: ""))
                            .bold()
                            .foregroundColor(Color.white.opacity(0.2))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .font(
                                Font.custom(Fonts().getFontLight(), size: 15)
                                    .weight(.bold)
                            )
                    }
                    .frame(width: 85,height: 40)
                    .padding(.leading,10)
                    .padding(.trailing,10)
                    .background(isDark ? Color(Colors().darkBtnMenu) : Color(Colors().lightBtnMenu))
                    .cornerRadius(10)
                    
                }, select: {
                    HStack{
                        Text(NSLocalizedString("qrCode", comment: ""))
                            .bold()
                            .foregroundColor(Color.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .font(
                                Font.custom(Fonts().getFontLight(), size: 15)
                                    .weight(.bold)
                            )
                    }
                    .frame(width: 85,height: 40)
                    .padding(.leading,10)
                    .padding(.trailing,10)
                    .background(isDark ? Color(Colors().darkBtnMenu) : Color(Colors().lightBtnMenu))
                    .cornerRadius(10)
                })
               .ipad()
            
            MyUserCodeView(isQrCode: false)
                 .tabItem(tag: 1, normal: {
            
                    HStack{
                        Text(NSLocalizedString("barCode", comment: ""))
                            .bold()
                            .foregroundColor(Color.white.opacity(0.2))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .font(
                                Font.custom(Fonts().getFontLight(), size: 15)
                                    .weight(.bold)
                            )
                    }
                    .frame(width: 85,height: 40)
                    .padding(.leading,10)
                    .padding(.trailing,10)
                    .background(isDark ? Color(Colors().darkBtnMenu) : Color(Colors().lightBtnMenu))
                    .cornerRadius(10)

                }, select: {
                    HStack{
                    
                        Text(NSLocalizedString("barCode", comment: ""))
                            .bold()
                            .foregroundColor(Color.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .font(
                                Font.custom(Fonts().getFontLight(), size: 15)
                                    .weight(.bold)
                            )
                    }
                    .frame(width: 85,height: 40)
                    .padding(.leading,10)
                    .padding(.trailing,10)
                    .background(isDark ? Color(Colors().darkBtnMenu) : Color(Colors().lightBtnMenu))
                    .cornerRadius(10)
                })
                 .ipad()
        } onTapReceive: { selectionTap in }
    }
}

