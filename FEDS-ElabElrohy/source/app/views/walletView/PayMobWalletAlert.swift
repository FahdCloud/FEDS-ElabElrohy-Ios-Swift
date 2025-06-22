//
//  PayMobWalletAlert.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 18/03/2024.
//

import SwiftUI

struct PayMobWalletAlert: View {
    
    @Binding var isPresented: Bool
    @Binding var openLink: Bool
    @Binding var firstInput: String
    @Binding var secondInput: String
    @Binding var isLoading: Bool
    var isPhone : Bool
    @Environment(\.presentationMode) var presentationMode
    @State private var toast: Toast? = nil
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                
                Text(isPhone ? NSLocalizedString("phonenumberDes", comment: "") : NSLocalizedString("enterAmount", comment: "") )
                
                VStack(spacing: -10){
                    VStack{
                        TextField("", text: $firstInput)
                            .textFieldStyle(
                                CustomTextFieldStyle(placeholder: NSLocalizedString("amount", comment: ""), placeholderColor: .black, placeholderBgColor: .white,image: "payment_tab_bar", isPassword: false, isEditing: !self.firstInput.isEmpty, isTapped: .constant(false))
                            )
                    }
                    .padding()
                    
                    if isPhone {
                        VStack {
                            TextField("", text: $secondInput)
                            
                                .textFieldStyle (
                                    CustomTextFieldStyle(placeholder: NSLocalizedString("phonenumber", comment: ""), placeholderColor: .black, placeholderBgColor: .white, image: "phone", isPassword: false, isEditing: !self.secondInput.isEmpty, isTapped: .constant(false))
                                )
                        }
                        .padding()
                    }
                }
                HStack {
                    Button(NSLocalizedString("cancel", comment: "")) {
                        isPresented = false
                    }
                    .foregroundColor(Color.white)
                    .frame(width: 120, height: 30, alignment: .center)
                    .background(Color(Colors().mainButtonColor.cgColor))
                    .cornerRadius(10)
                    
                    Button(NSLocalizedString("charge", comment: "")) {
                        if !isPhone {
                            submitCharge(amount: Double(firstInput)!)
                        } else {
                            submitChargeForPhone(phone: secondInput, amount: Double(firstInput)!)
                        }
                    }
                    .foregroundColor(Color.white)
                    .frame(width: 120, height: 30, alignment: .center)
                    .background(Color(Colors().mainButtonColor.cgColor))
                    .cornerRadius(10)
                }
                
                //                    }
            }
            .padding()
            .background(BlurView())
            .background(Color.white)
            .cornerRadius(15)
            .shadow(radius: 10)
            .frame(maxWidth: 300)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(
                Color.primary.opacity(0.35)
            )
        }
        .toastView(toast: $toast)
    }
    
    func submitCharge(amount:Double){
        isLoading = true
        
        do {
            try Api().payWallet(authToken: self.authToken, chargeValue: amount, paymentPhoneNumber: "", paymentTypeToken: Constants().PAYMENT_TYPE_BANK) { url,status, msg in
                if status == Constants().STATUS_SUCCESS {
                    
                    UserDefaultss().saveStrings(value: url, key: "paymentLink")
                    isLoading = false
                    self.openLink = true
                } else {
                    isLoading = false
                    toast = Helper.showToast(style: .error, message:msg)
                }
            }
        } catch {
            isLoading = false
            toast = Helper.showToast(style: .error, message: NSLocalizedString("message_error_in_fetching_data", comment: ""))
        }
        
    }
    
    func submitChargeForPhone(phone :String , amount :Double){
        isLoading = true
        
        do {
            try Api().payWallet(authToken: self.authToken, chargeValue: amount, paymentPhoneNumber: phone, paymentTypeToken: Constants().PAYMENT_TYPE_PHONE_WALLET) {url, status, msg in
                if status == Constants().STATUS_SUCCESS {
                    //                    self.paymentLink = url
                    UserDefaultss().saveStrings(value: url, key: "paymentLink")
                    isLoading = false
                    self.openLink = true
                    
                    
                } else {
                    isLoading = false
                    
                    toast = Helper.showToast(style: .error, message:msg)
                }
            }
        } catch {
            isLoading = false
            
            toast = Helper.showToast(style: .error, message: NSLocalizedString("message_error_in_fetching_data", comment: ""))
        }
    }
}
