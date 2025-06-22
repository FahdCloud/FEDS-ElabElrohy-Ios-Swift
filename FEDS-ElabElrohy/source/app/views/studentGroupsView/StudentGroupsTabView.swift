//
//  EducationGroupsView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 30/10/2023.
//

import SwiftUI


import AxisTabView

@available(iOS 16.0, *)
struct StudentGroupsTabView: View {
    @State private var selection: Int = 0

    var body: some View {
        AxisTabView(selection: $selection, constant: ATConstant(axisMode: .bottom)) { state in
            ATMaterialStyle(state)
        } content: {
            MyGroups(isFinished: false)
                .tabItem(tag: 0, normal: {
                    HStack{
                        Text(NSLocalizedString("unFinished", comment: ""))
                            .bold()
                            .foregroundColor(Color.white.opacity(0.2))
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
                    
                }, select: {
                    HStack{
                        Text(NSLocalizedString("unFinished", comment: ""))
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
            
            MyGroups(isFinished: true)
                .tabItem(tag: 1, normal: {
            
                    HStack{
                        Text(NSLocalizedString("finished", comment: ""))
                            .bold()
                            .foregroundColor(Color.white.opacity(0.2))
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

                }, select: {
                    HStack{
                    
                        
                        Text(NSLocalizedString("finished", comment: ""))
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

