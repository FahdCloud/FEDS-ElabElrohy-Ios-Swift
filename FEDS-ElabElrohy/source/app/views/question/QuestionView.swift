//
//  QuestionView.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 07/04/2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct QuestionView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()


    var body: some View {
        VStack{
            
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                    .frame(height: 150)
                    .edgesIgnoringSafeArea(.top)
                
                
                Text(NSLocalizedString("ques", comment: ""))
                    .font(
                        Font.custom(Fonts().getFontBold(), size: 30).weight(.bold))
                    .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardLightText))
                    .padding(.top, 100)
                
            }
            Spacer()
            VStack{
                Image("empty_data")
                    .resizable()
                    .frame(width: 300,height: 300, alignment: .center)
                    .padding()
                
                Text(NSLocalizedString("msg_comming_soon", comment: ""))
                    .font(
                        Font.custom(Fonts().getFontLight(), size: 20))
                    .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                    .multilineTextAlignment(.center)
                    .underline()
                    .lineSpacing(3)
            }
            .padding(.bottom, 200)
        }
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        .ipad()
        .edgesIgnoringSafeArea(.all)
    }
}

