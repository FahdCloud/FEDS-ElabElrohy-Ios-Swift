//
//  ForgetPassVm.swift
//  FEDS-Dev-Ver-Two
//
//  Created by Omar Pakr on 27/01/2025.
//

import Foundation

class ForgetPassVm: ObservableObject {
    
    @Published var genralVm : GeneralVm = GeneralVm()
    
    @Published var verifyEmailOrPhone = ""
    @Published var verifyCode = ""
    @Published var newPassword = ""
    @Published var confirmPassword = ""
    
    @Published var indexForChangeView: Int = 1
    
    @Published var showiLoginFromVerfiyEmail: Bool = false
    @Published var isNewPasswordVisible: Bool = false
    @Published var isConfirmPasswordVisible: Bool = false
    @Published var isValidNewPass: Bool = true
    @Published var isValidConfirmPass: Bool = true
    @Published var isValidVerfiyEmail: Bool = true
    @Published var isLoading: Bool = false
    @Published var showFaliedToast = false
    @Published var showPassword = false
    @Published var showSuccessedToast = false
    @Published var showingOTPSheet: Bool = false
    @Published var showLoginFromChangePass: Bool = false
    @Published var showingForgotPasswordSheet: Bool = false
    @Published var toast: Toast? = nil
    
    func checkUser(){
        self.isLoading = true
        do {
            try Api().checkUser(languageToken: self.genralVm.constants.APP_LANGUAGE_AR, userEmailOrPhone: self.verifyEmailOrPhone)
            { status, msg,data  in
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    self.indexForChangeView = 2
                    self.isLoading = false
                    self.toast = Helper.showToast(style: .success, message: msg)
                    UserDefaultss().saveStrings(value: data.userData?.userToken ?? "", key: "forgetPassUserToken")

                }  else {
                    self.isLoading = false
                    self.toast = Helper.showToast(style: .error, message: msg)
                }
            }
        }  catch {
            self.isLoading = false
            self.toast = Helper.showToast(style: .error, message: "an error happened")
        }
    }
    
    func verifyForgetPassCode(){
        self.isLoading = true
        let userrrrr = UserDefaultss().restoreString(key: "forgetPassUserToken")
        let convertedCode = convertToEnglishDigits(self.verifyCode)
        do {
            try Api().verifyForgetPassCode(languageToken: self.genralVm.constants.APP_LANGUAGE_AR, userToken: userrrrr, verificationCode: convertedCode)
            { status, msg  in
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    self.indexForChangeView = 3
                    self.isLoading = false
                    self.toast = Helper.showToast(style: .success, message: msg)
                }  else {
                    self.isLoading = false
                    self.verifyCode = ""
                    self.toast = Helper.showToast(style: .error, message: msg)
                }
            }
        }  catch {
            self.isLoading = false
            self.verifyCode = ""
            self.toast = Helper.showToast(style: .error, message: "an error happened")
        }
    }
    
    func changeFrogetPassword(){
        self.isLoading = true
        let userrrrr = UserDefaultss().restoreString(key: "forgetPassUserToken")
        do {
            try Api().changePassword(userAuthorizeToken: "", userToken: userrrrr, userPassword: self.newPassword, languageToken: self.genralVm.constants.APP_LANGUAGE_AR)
            { status, msg  in
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    self.showLoginFromChangePass = true
                    self.isLoading = false
                    self.toast = Helper.showToast(style: .success, message: msg)
                   
                }  else {
                    self.isLoading = false
                    self.toast = Helper.showToast(style: .error, message: msg)
                    
                }
            }
        }  catch {
            self.isLoading = false
            self.toast = Helper.showToast(style: .error, message: "an error happened")
        }
    }
    
    private func convertToEnglishDigits(_ input: String) -> String {
            let arabicDigits: [Character: Character] = [
                "٠": "0", "١": "1", "٢": "2", "٣": "3", "٤": "4",
                "٥": "5", "٦": "6", "٧": "7", "٨": "8", "٩": "9"
            ]
            
            return String(input.map { arabicDigits[$0] ?? $0 })
        }
}
