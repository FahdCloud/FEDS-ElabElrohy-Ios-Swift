//
//  TeachersTabBar.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 27/11/2023.
//

import Foundation
import SwiftUI

import AxisTabView

@available(iOS 16.0, *)
struct TeacherTabBar: View {
    @State private var selection: Int = 0

    var body: some View {
        AxisTabView(selection: $selection, constant: ATConstant(axisMode: .bottom)) { state in
            ATMaterialStyle(state)
        } content: {
        
            GroupsView(isFinished: false)
                .tabItem(tag: 2, normal: {
                    HStack{
                        Text(NSLocalizedString("groups", comment: ""))
                            .bold()
                            .foregroundColor(Color.white.opacity(0.2))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 15)
                                    .weight(.bold)
                            )
                    }
                 
                }, select: {
                    HStack{
                        Text(NSLocalizedString("groups", comment: ""))
                            .bold()
                            .foregroundColor(Color.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 15)
                                    .weight(.bold)
                            )
                    }
                    .frame(width: 85,height: 40)
                    .padding(.leading,10)
                    .padding(.trailing,10)
                    .background(Color(Colors().mainColor))
                    .cornerRadius(10)
                })
                .ipad()
            
            
            SchudleTimeView()
                .tabItem(tag: 3, normal: {
                    HStack{
                        Text(NSLocalizedString("schudelTime", comment: ""))
                            .bold()
                            .foregroundColor(Color.white.opacity(0.2))
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 15)
                                    .weight(.bold)
                            )
                    }
                  
                }, select: {
                    HStack{
                        Text(NSLocalizedString("schudelTime", comment: ""))
                            .bold()
                            .foregroundColor(Color.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 15)
                                    .weight(.bold)
                            )
                    }
                    .frame(width: 85,height: 40)
                    .padding(.leading,10)
                    .padding(.trailing,10)
                    .background(Color(Colors().mainColor))
                    .cornerRadius(10)
                })
                .ipad()
       
        } onTapReceive: { selectionTap in }
    }
}

