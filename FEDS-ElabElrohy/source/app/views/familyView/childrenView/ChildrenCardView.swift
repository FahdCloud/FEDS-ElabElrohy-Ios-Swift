//
//  ChildrenCardView.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 07/11/2023.
//

import SwiftUI

struct ChildrenCardView: View {
    var children : MyChild
    
    var body: some View {
        HStack {
            HStack (spacing:10){
                HStack(alignment: .center, spacing: 0) {
                    CustomImageUrl(url: (children.userInfoData?.userImageUrl) ?? "",width: 50,height: 50)
                }
                .padding(0)
                .frame(width: 64, height: 64, alignment: .center)
                
                VStack {
                    Text(children.userInfoData?.userNameCurrent ?? "")
                        .font(
                            Font.custom("GE SS Unique", size: 14)
                                .weight(.light)
                        )
                        .foregroundColor(Color(red: 0.18, green: 0.16, blue: 0.62))
                        .frame(width: 39, alignment: .topLeading)
                    
                    
                    Text(children.relativeRelationNameCurrent ?? "")
                        .font(
                            Font.custom("GE SS Unique", size: 12)
                                .weight(.light)
                        )
                        .foregroundColor(Color(red: 0.39, green: 0.38, blue: 0.71))
                }
            }
            .padding(.leading, 12)
            .padding(.trailing, 52)
            .padding(.top, 17)
            .padding(.bottom, 14)
            .cornerRadius(40)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.18, green: 0.16, blue: 0.62), lineWidth: 1)
            )
        }
    }
}
