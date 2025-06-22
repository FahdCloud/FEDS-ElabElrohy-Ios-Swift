//
//  OTPVerificationView.swift
//  FEDS-Dev-Ver-Two
//
//  Created by Omar Pakr on 28/01/2025.
//

import SwiftUI

struct OTPVerificationView: View {
    @StateObject var genralVm: GeneralVm = GeneralVm()
    @StateObject var forgetPassVm: ForgetPassVm
    @FocusState private var isKeyboardShowing: Bool
    
    @State private var showLoginFromOTPView = false
    @State private var timer: Int = 60
    @State private var isTimerRunning: Bool = true
    
    var body: some View {
        NavigationStack{
            VStack {
                Text(NSLocalizedString("otp_sent_message", comment: ""))
                    .font(Font.custom(Fonts().getFontBold(), size: 20).weight(.bold))
                    .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                
                Text(self.forgetPassVm.verifyEmailOrPhone)
                    .font(Font.custom(Fonts().getFontBold(), size: 20).weight(.bold))
                    .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                
                
                HStack(spacing: 0) {
                    ForEach(0..<6, id: \.self) { index in
                        OTPTextBox(index)
                    }
                }
                .background {
                    TextField("", text: $forgetPassVm.verifyCode.limit(6))
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .frame(width: 1, height: 1)
                        .opacity(0.001)
                        .blendMode(.screen)
                        .focused($isKeyboardShowing)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    isKeyboardShowing.toggle()
                }
                .padding(.bottom, 20)
                .padding(.top, 10)
                
                if isTimerRunning {
                    HStack(spacing: 0){
                        
                        Text(NSLocalizedString("resend_code_timer", comment: ""))
                            .font(Font.custom(Fonts().getFontLight(), size: 20).weight(.light))
                            .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                            .padding(.bottom, 10)
                        
                        Text("\(timer)")
                            .font(Font.custom(Fonts().getFontLight(), size: 20).weight(.light))
                            .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                            .padding(.bottom, 10)
                        
                    }
                } else {
                    Button(action: {
                        resendCode()
                    }) {
                        
                        Text(NSLocalizedString("resend", comment: ""))
                            .font(Font.custom(Fonts().getFontBold(), size: 20).weight(.bold))
                            .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                            .underline()
                    }
                    .padding(.bottom, 10)
                }
                
                ButtonAction(text: NSLocalizedString("verify", comment: ""), color: Color(Colors().mainButtonColor.cgColor)) {
                    self.forgetPassVm.verifyForgetPassCode()
                }
                .disabled(forgetPassVm.verifyCode.count < 6)
                .opacity(forgetPassVm.verifyCode.count < 6 ? 0.5 : 1)
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .top)
            .background(Color(Colors().whiteColorWithTrans))
            .toastView(toast: $forgetPassVm.toast)
            .fullScreenCover(isPresented: $showLoginFromOTPView) {
                LoginView()
            }
            .navigationTitle(NSLocalizedString("verify_otp", comment: ""))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton {
                        showLoginFromOTPView.toggle()
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
            .onAppear {
                startTimer()
            }
        }
    }
    
    @ViewBuilder
    func OTPTextBox(_ index: Int) -> some View {
        ZStack {
            if forgetPassVm.verifyCode.count > index {
                let startIndex = forgetPassVm.verifyCode.startIndex
                let charIndex = forgetPassVm.verifyCode.index(startIndex, offsetBy: index)
                let charToString = String(forgetPassVm.verifyCode[charIndex])
                Text(charToString.applyingTransform(.toLatin, reverse: false) ?? charToString)
                    .foregroundStyle(Color.black)
                    .font(Font.custom(Fonts().getFontBold(), size: 30).weight(.bold))
//                    .environment(\.locale, Locale(identifier: "en_US"))
            } else {
                Text("")
            }
        }
        .frame(width: 45, height: 45)
        .background {
            let status = (isKeyboardShowing && forgetPassVm.verifyCode.count == index)
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(status ? Color.black : .gray, lineWidth: status ? 4 : 3)
                .animation(.easeInOut(duration: 0.2), value: status)
        }
        .frame(maxWidth: .infinity)
    }
    
    func startTimer() {
        timer = 60
        isTimerRunning = true
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { t in
            if timer > 0 {
                timer -= 1
            } else {
                isTimerRunning = false
                t.invalidate()
            }
        }
    }
    
    func resendCode() {
        self.forgetPassVm.checkUser()
        startTimer()
    }
}

extension Binding where Value == String{
    func limit(_ length: Int)->Self{
        if self.wrappedValue.count > length{
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}
