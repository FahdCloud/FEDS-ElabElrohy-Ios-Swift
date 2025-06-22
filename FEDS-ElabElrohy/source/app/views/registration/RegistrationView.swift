//
//  Registration.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 16/08/2023.
//

import SwiftUI
import BottomSheetSwiftUI

@available(iOS 16.0, *)
struct RegistrationView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @State private var bottomSheetPositionLogout: BottomSheetPosition = .hidden
    @State private var visualEffect  = VisualEffect.systemDark
    let switchablePositions: [BottomSheetPosition] = [.dynamic]
    
    let logoutMsg = UserDefaultss().restoreString(key: "logoutMsg")


    @State private var showLoginFromReg: Bool = false
    @State private var showSignupFromReg: Bool = false

    var body: some View {
        
        ZStack {
            background
            ZStack {
                languageToggle
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding()
                
                Spacer()
                
                if showLoginFromReg {
                    LoginView()
                } else if showSignupFromReg {
                    SignUp()
                } else {
                    bottomStack
                }
            }
        }
        .onAppear(perform: {
        
            if  Validation.IsValidContent(text: logoutMsg){
                bottomSheetPositionLogout = .dynamic
            }
        })
        .onDisappear {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
        }
        .bottomSheet(
            bottomSheetPosition: $bottomSheetPositionLogout,
            switchablePositions: switchablePositions,
            headerContent: {},
            mainContent: {
                
                VStack{
                    
                    HStack(spacing:10){
                        Image("error_alert")
                            .resizable()
                            .frame(width: 35,height: 35)
                        Text(NSLocalizedString("alert", comment: ""))
                            .lineSpacing(3)
                            .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 40)
                                    .weight(.bold)
                            )
                            .lineLimit(3)
                    }
                    .frame(alignment: .center)
                    .padding(.bottom, 10)
                    
                    Text(logoutMsg)
                        .font(
                            Font.custom(Fonts().getFontBold(), size: 24)
                                .weight(.bold)
                        )
                        .padding(.vertical, 20)
                    ButtonAction(text:NSLocalizedString("ok", comment: ""),textSize : 30 , color: .red) {
                            Helper.removeUserDefaultsAndCashes()
                            bottomSheetPositionLogout = .hidden
                    }
                        .frame(width: 180)
                    
                }
                .padding(.all, 15)
                
            }
            
        )
        .enableSwipeToDismiss(false)
        .enableTapToDismiss(false)
        .enableBackgroundBlur(true)
        .enableContentDrag(true)
        .backgroundBlurMaterial(visualEffect)
    }

    var languageToggle: some View {
        HStack(alignment: .center, spacing: 10) {
            if self.genralVm.lang == genralVm.constants.APP_IOS_LANGUAGE_AR  {
                
                Image("langEN")
                    .resizable()
                    .frame(width: 40, height: 40)
            }else{
                Image("langAR")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
            Text(NSLocalizedString("lange", comment: ""))
                .foregroundColor(Color(Colors().lightBodyText))
                .font(Font.custom(Fonts().getFontBold(), size: 24).weight(.bold))
        }
        .onTapGesture {
            Helper().openSettings()
        }
        .padding(10)
        .frame(width: 200, height: 60, alignment: .center)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.trailing, -20)
    }

    var bottomStack: some View {
        VStack(spacing: 10) {
            signUpButton
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .edgesIgnoringSafeArea(.bottom)
            .padding(.bottom, -340)
            .padding(.leading, -20)
        
            signInButton
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            .edgesIgnoringSafeArea(.bottom)
            .padding(.bottom, 10)
            .padding(.trailing, -20)

        }
    
    }

    var signInButton: some View {
        Button(action: {
            showLoginFromReg.toggle()
        }) {
            Text(NSLocalizedString("signIn", comment: ""))
                .foregroundColor(Color(Colors().lightBodyText))
                .font(Font.custom(Fonts().getFontBold(), size: 22))
        }
        .frame(width: 200, height: 60, alignment: .center)
        .background(Color.white)
        .cornerRadius(10)
    }

    var signUpButton: some View {
        Button(action: {
            showSignupFromReg.toggle()
        }) {
            HStack {
                Text(NSLocalizedString("signUp", comment: ""))
                    .foregroundColor(Color(Colors().lightBodyText))
                    .font(Font.custom(Fonts().getFontBold(), size: 22))
                    .padding(.leading, 10)
                
                Spacer()
            }
        }
        .frame(width: 200, height: 60, alignment: .center)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.leading)
    }

    var background: some View {
        if self.genralVm.lang == genralVm.constants.APP_IOS_LANGUAGE_AR  {
            Image("img_background_registration_ar")
                .resizable()
                .ignoresSafeArea()
            
            
        }else {
            Image("img_background_registration_en")
                .resizable()
                .ignoresSafeArea()
        }
       
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showLoginFromReg = false
        showSignupFromReg = false
      }
}

