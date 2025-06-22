//
//  ChangePasswordView.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 17/04/2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct ChangePasswordView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @State private  var showPassword : Bool = false
    @State private  var isLoading : Bool = false
    @State private  var showConfirmPassword : Bool = false
    @State private var showRegFromChangePass : Bool = false
    @State private var showProfileInfoFromChangePass : Bool = false
    @State private var toast: Toast? = nil
    @State private var dissapearView : Bool = false


    @State var password = ""
    @State var confirmPassword = ""
    @State var msg = ""
    

    var body: some View {
        NavigationView {
            VStack {
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                        .frame(height: 150) // Adjust height as needed
                        .edgesIgnoringSafeArea(.top)
                        .cornerRadius(20, corners: [.allCorners])
                    
                    HStack (spacing:10){
                        Image("key-icon")
                            .resizable()
                            .frame(width: 40,height: 40)
                        
                        Text(NSLocalizedString("userPasswordFiled", comment: ""))
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 30)
                                    .weight(.bold)
                            )
                            .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                        
                    }
                    .padding(.top, 70)
                    
                }
                .edgesIgnoringSafeArea(.all)
                
                ScrollView{
                    // Main content
                    VStack(spacing: 4){
                        
                        Image("change_pass_icon")
                            .resizable()
                            .frame(width: 250,height: 250)
                            .padding(.vertical, 40)
                        
                        passwordField
                            .padding(.vertical, 5)
                            .padding(.horizontal, 35)
                        
                        passwordConfirmField
                            .padding(.vertical, 5)
                            .padding(.horizontal, 35)
                    }
                    .frame(height: 500)
                    .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
                    .cornerRadius(10)
                    .shadow(color: genralVm.isDark ? .white: .black, radius: 5, x: 0, y: 2)
                    .offset(y: -100)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 15)
                    
                    Spacer()
                    
                    ButtonAction(text:NSLocalizedString("changePassword", comment: ""), color: .green) {
                        getFiledsData()
                        
                        
                    }
                    .padding(.bottom, 40)
                    .padding(.horizontal, 60)
                    .shadow(color: genralVm.isDark ? .white: .black, radius: 5, x: 0, y: 2)
                    
                }
               
                
            }
            .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        }
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        .ipad()
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < 0 {
                        self.showProfileInfoFromChangePass.toggle()
                    }else if value.translation.width > 0 {
                        self.showProfileInfoFromChangePass.toggle()
                    }
                }
        )
        .fullScreenCover(isPresented: $showProfileInfoFromChangePass, content: {
            ProfileView()
        })
        .fullScreenCover(isPresented: $showRegFromChangePass, content: {
            RegistrationView()
               
        })
        .onDisappear(perform: {
            clearStatesWithAction(valueState: &dissapearView)
            showRegFromChangePass = false
            showProfileInfoFromChangePass = false
        })
        .toastView(toast: $toast)
    }
    
    var passwordField: some View {
        
        VStack{
            if showPassword{
                TextField("", text: $password)
                
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("userPasswordFiled", comment: ""), placeholderColor: .black, placeholderBgColor: .white,image: "auth_password_png", isPassword: true, isEditing: !self.password.isEmpty, isTapped: $showPassword)
                    )
            } else {
                SecureField("", text: $password)
                
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("userPasswordFiled", comment: ""), placeholderColor: .black, placeholderBgColor: .white,image: "auth_password_png", isPassword: true, isEditing: !self.password.isEmpty, isTapped: $showPassword)
                    )
            }
        }
    }
    
    
    var passwordConfirmField: some View {
        
        VStack{
            if showConfirmPassword{
                TextField("", text: $confirmPassword)
                
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("userConfirmPasswordFiled", comment: ""), placeholderColor: .black, placeholderBgColor: .white,image: "auth_password_png", isPassword: true, isEditing: !self.confirmPassword.isEmpty, isTapped: $showConfirmPassword)
                    )
            } else {
                SecureField("", text: $confirmPassword)
                
                    .textFieldStyle(
                        CustomTextFieldStyle(placeholder: NSLocalizedString("userConfirmPasswordFiled", comment: ""), placeholderColor: .black, placeholderBgColor: .white,image: "auth_password_png", isPassword: true, isEditing: !self.confirmPassword.isEmpty, isTapped: $showConfirmPassword)
                    )
            }
        }
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showRegFromChangePass = false
        showProfileInfoFromChangePass = false
    }
}

@available(iOS 16.0, *)
extension ChangePasswordView {
    // functions
  
    private func getFiledsData(){
        if Helper.isConnectedToNetwork() {
         
            let userPassword : String = password
            let userConfirmPassword : String = confirmPassword
            
            checkValidation(userPass: userPassword, userConfirmPass: userConfirmPassword)
        } else {
            toast = Helper.showToast(style: .error, message: NSLocalizedString("error_connected_to_network", comment: ""))
            return
        }
    }
    
    
    private func checkValidation(userPass : String , userConfirmPass:String){
      
        let isValidPassword = Validation.IsValidContent(text: userPass,length: 4)
        let isValidConfirmPassword = Validation.IsValidContent(text: userConfirmPass,length: 4)
        
        if !isValidPassword {
            toast = Helper.showToast(style: .error, message: NSLocalizedString("msg_inValid_password", comment: ""))
            return
        }
         
        if !isValidConfirmPassword {
            toast = Helper.showToast(style: .error, message: NSLocalizedString("msg_inValid_confirmPassword", comment: ""))
            return
        }
        
    
        if userPass != userConfirmPass{
            toast = Helper.showToast(style: .error, message: NSLocalizedString("msg_inValid_matchPassword", comment: ""))
            return
        }
        callApi(userPassword: userPass)
    }
    
    func callApi(userPassword : String ){
        self.isLoading = true
        do {
            try Api().changePassword(userAuthorizeToken: self.genralVm.authToken, userToken: self.genralVm.userToken, userPassword: userPassword, languageToken: genralVm.constants.APP_LANGUAGE_AR)
                { status, msg in
                    if status == self.genralVm.constants.STATUS_SUCCESS {
                    Helper.removeUserDefaultsAndCashes()
                    self.isLoading = false
                    self.showRegFromChangePass = true
                    self.msg = msg
                    self.toast = Helper.showToast(style: .success, message: msg)
                    
                    
                }  else {
                    self.isLoading = false
                    self.msg = msg
                    self.toast = Helper.showToast(style: .error, message: msg)
                }
               
            }
        }  catch {
            self.isLoading = false
            self.msg = error.localizedDescription
            self.toast = Helper.showToast(style: .error, message: msg)
        }
        
    }

}
