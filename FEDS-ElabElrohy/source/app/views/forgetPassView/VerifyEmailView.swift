//
//  VerifyEmailView.swift
//  FEDS-Dev-Ver-Two
//
//  Created by Omar Pakr on 27/01/2025.
//

import SwiftUI

struct VerifyEmailView: View {
    @StateObject var forgetPassVm: ForgetPassVm = ForgetPassVm()
    @StateObject var genralVm: GeneralVm = GeneralVm()
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20){
                TextField("", text: $forgetPassVm.verifyEmailOrPhone)
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("userEmail", comment: ""),
                                             placeholderColor: .black,
                                             placeholderBgColor: .white,
                                             image: "person",
                                             isPassword: false,
                                             isEditing: !self.forgetPassVm.verifyEmailOrPhone.isEmpty,
                                             isTapped: $forgetPassVm.showPassword)
                    )
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                
                ButtonAction(text: NSLocalizedString("next", comment: ""), color: Color(Colors().mainButtonColor.cgColor)) {
                    forgetPassVm.checkUser()
                }
                Spacer()
            }
            .padding()
            .navigationTitle(NSLocalizedString("forgetPassword", comment: ""))
            .background(Color(Colors().whiteColorWithTrans))
            .toastView(toast: $forgetPassVm.toast)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton {
                        forgetPassVm.showiLoginFromVerfiyEmail.toggle()
                    }
                }
            }
        }
        .background(Color(Colors().whiteColorWithTrans))
        .ipad()
        .overlay(
            self.forgetPassVm.isLoading ?
            GeometryReader { geometry in
                ZStack {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .transition(.scale)
                } } : nil
        )
        .fullScreenCover(isPresented: $forgetPassVm.showiLoginFromVerfiyEmail, content: {
            LoginView()
        })
        
    }
}

