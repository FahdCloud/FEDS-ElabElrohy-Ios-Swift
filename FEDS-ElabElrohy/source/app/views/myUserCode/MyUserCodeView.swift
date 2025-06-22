//
//  UserCode.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 22/11/2023.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

@available(iOS 16.0, *)
struct MyUserCodeView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()

    let userFullCode = UserDefaultss().restoreString(key: "userFullCode")
    let isQrCode : Bool
    @State private var showMoreFromMyuserCode : Bool = false
    
    var body: some View {
       
        NavigationView {
            VStack {
                if isQrCode {
                    QRCodeImageView(theme: genralVm.isDark ? .dark : .light, code: userFullCode)
                        .frame(width: 200, height: 200)
                    Text(userFullCode)
                        .kerning(5.0)
                        .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                        .font(
                            Font.custom(Fonts().getFontBold(), size: 28)
                                .weight(.bold)
                            )
                        .lineLimit(1)
                        .padding(.top, 50)
                } else {
                    
                    BarcodeGeneratorView(barcodeString: userFullCode)
                                .frame(width: 200, height: 100)
                    Text(userFullCode)
                        .kerning(5.0)
                        .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                        .font(
                            Font.custom(Fonts().getFontBold(), size: 28)
                                .weight(.bold)
                            )
                        .lineLimit(1)
                        .padding(.top, 10)
                }
                
            }
            .fullScreenCover(isPresented: $showMoreFromMyuserCode, content: {
                StudentMainTabView()
            })
            .onDisappear(perform: {
                clearStatesWithAction(valueState: &genralVm.dissapearView)
                showMoreFromMyuserCode = false
            })
            .navigationBarTitle(NSLocalizedString("userCode", comment: ""), displayMode: .inline)
           
            .navigationBarItems(leading: CustomBackButton(){
                clearStatesWithAction(valueState: &showMoreFromMyuserCode)
            })
        }
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
            .ipad()
        
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showMoreFromMyuserCode = false
    }
 }




