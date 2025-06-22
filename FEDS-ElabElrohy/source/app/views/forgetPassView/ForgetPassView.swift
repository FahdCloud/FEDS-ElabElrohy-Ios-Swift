//
//  ForgetPassView.swift
//  FEDS-Dev-Ver-Two
//
//  Created by Omar Pakr on 27/01/2025.
//

import SwiftUI

struct ForgetPassView: View {
    @StateObject var forgetPassVm: ForgetPassVm = ForgetPassVm()
    var body: some View {
            if forgetPassVm.indexForChangeView == 1 {
                VerifyEmailView(forgetPassVm: forgetPassVm)
            }else if forgetPassVm.indexForChangeView == 2 {
                OTPVerificationView(forgetPassVm: forgetPassVm)
            }else if forgetPassVm.indexForChangeView == 3{
                ResetPasswordView(forgetPassVm: forgetPassVm)
            }
        
    }
}
