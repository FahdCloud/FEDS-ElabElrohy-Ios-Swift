//
//  ResetPasswordView.swift
//  FEDS-Dev-Ver-Two
//
//  Created by Omar Pakr on 28/01/2025.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @StateObject var genralVm : GeneralVm = GeneralVm()
    @StateObject var forgetPassVm: ForgetPassVm
    @State private var showPassword : Bool = false
    @State private var showNewPassword : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                
                VStack{
                    if showPassword{
                        TextField("", text: $forgetPassVm.newPassword)
                            .textFieldStyle(
                                CustomTextFieldStyle(placeholder: NSLocalizedString("newPassword", comment: ""),
                                                     placeholderColor: .black,
                                                     placeholderBgColor: .white,
                                                     image: "lock-fill",
                                                     isPassword: true,
                                                     isEditing: !self.forgetPassVm.newPassword.isEmpty,
                                                     isTapped: $showPassword)
                            )
                    } else {
                        SecureField("", text: $forgetPassVm.newPassword)
                            .textFieldStyle(
                                CustomTextFieldStyle(placeholder: NSLocalizedString("newPassword", comment: ""),
                                                     placeholderColor: .black,
                                                     placeholderBgColor: .white,
                                                     image: "lock-fill",
                                                     isPassword: true,
                                                     isEditing: !self.forgetPassVm.newPassword.isEmpty,
                                                     isTapped: $showPassword)
                            )
                    }
                }
                
                VStack{
                    if showNewPassword{
                        TextField("", text: $forgetPassVm.confirmPassword)
                            .textFieldStyle(
                                CustomTextFieldStyle(placeholder: NSLocalizedString("confirmPassword", comment: ""),
                                                     placeholderColor: .black,
                                                     placeholderBgColor: .white,
                                                     image: "lock-fill",
                                                     isPassword: true,
                                                     isEditing: !self.forgetPassVm.confirmPassword.isEmpty,
                                                     isTapped: $showNewPassword)
                            )
                    } else {
                        SecureField("", text: $forgetPassVm.confirmPassword)
                            .textFieldStyle(
                                CustomTextFieldStyle(placeholder: NSLocalizedString("confirmPassword", comment: ""),
                                                     placeholderColor: .black,
                                                     placeholderBgColor: .white,
                                                     image: "lock-fill",
                                                     isPassword: true,
                                                     isEditing: !self.forgetPassVm.confirmPassword.isEmpty,
                                                     isTapped: $showNewPassword)
                            )
                           
                    }
                }
                ButtonAction(text: NSLocalizedString("save", comment: ""), color: Color(Colors().mainButtonColor.cgColor)){
                    self.forgetPassVm.changeFrogetPassword()
                }
                .disabled(!(forgetPassVm.newPassword == forgetPassVm.confirmPassword))
                .opacity((forgetPassVm.newPassword == forgetPassVm.confirmPassword) ? 1 : 0.5)
                Spacer()
            }
            .padding(.all, 20)
            .background(Color(Colors().whiteColorWithTrans))
            .navigationTitle(NSLocalizedString("resetPassword", comment: ""))
        }
        .fullScreenCover(isPresented: $forgetPassVm.showLoginFromChangePass, content: {
            LoginView()
        })
        .background(Color(Colors().whiteColorWithTrans))     
        .ipad()
        .toastView(toast: $forgetPassVm.toast)
        .overlay(
            self.forgetPassVm.isLoading ?
            GeometryReader { geometry in
                ZStack {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .transition(.scale)
                } } : nil
        )
    }
}
