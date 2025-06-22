//
//  CodeWalletAlert.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 18/03/2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct CodeWalletAlert: View {
    @State var routeFrom: String
    
    @Binding var isPresented: Bool
    @Binding var firstInput: String
    @Binding var isLoading: Bool
    @Environment(\.presentationMode) var presentationMode
    @State private var toast: Toast? = nil
    @State var showOnlineContentLevelView: Bool = false
    @State var showMyOnlineContentLevelView: Bool = false
    
    let constants = Constants()
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 20) {
                
                Text(NSLocalizedString("typeCardCode", comment: ""))
                
                VStack(spacing: -10){
                    VStack{
                        TextField("", text: $firstInput)
                            .textFieldStyle(
                                CustomTextFieldStyle(placeholder: NSLocalizedString("typeCardCode", comment: ""), placeholderColor: .black, placeholderBgColor: .white,image: "qr-code", isPassword: false, isEditing: !self.firstInput.isEmpty, isTapped: .constant(false))
                            )
                            .keyboardType(.default)
                    }
                    .padding()
                    
                    
                }
                HStack {
                    
                    Button {
                        isPresented = false
                    } label: {
                        Text(NSLocalizedString("cancel", comment: ""))
                            .frame(width: 120, height: 30)
                    }
                    .foregroundColor(Color.white)
                    .frame(width: 120, height: 30, alignment: .center)
                    .background(Color(Colors().mainColor.cgColor))
                    .cornerRadius(10)
                    
                    Button {
                        submitCode(code: firstInput)
                    } label: {
                        Text(NSLocalizedString("done", comment: ""))
                            .frame(width: 120, height: 30)
                        
                    }
                    .foregroundColor(Color.white)
                    .frame(width: 120, height: 30, alignment: .center)
                    .background(Color(Colors().mainColor.cgColor))
                    .cornerRadius(10)
                }
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
        
        
        
        .fullScreenCover(isPresented: $showOnlineContentLevelView) {
            OnlineContentLevelsView()
                .environmentObject(ScreenshotDetector())
                .environmentObject(ScreenRecordingDetector())
        }
        
      
        
        
        .toastView(toast: $toast)
    }
    
    func submitCode(code:String){
        isLoading = true
        do {
            try Api().payCode(authToken: self.authToken, code: Helper.arToEn(number: code)){ status,msg in
                if status == Constants().STATUS_SUCCESS {
                    isLoading = false
                    toast = Helper.showToast(style: .success, message:msg)
                    
                    if routeFrom == constants.Wallet_Online_Levels_Content_View  {
                        showOnlineContentLevelView = true
               
                    }else if routeFrom == constants.Wallet_My_Online_Levels_Content_View {
                        showMyOnlineContentLevelView.toggle()
                    }
                    
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
