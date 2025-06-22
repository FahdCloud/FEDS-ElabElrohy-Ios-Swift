
//
//  AboutClientView.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 27/03/2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct newWallet: View {
    @State private var toast: Toast? = nil
    @State private var backFromAboutClient : Bool = false
    @State private var showingCustomAlertPhone : Bool = false
    @State private var showingCustomAlertBank : Bool = false
    @State private var showCustomCode : Bool = false
    @State private var showHome : Bool = false
    @State private var openLink : Bool = false
    @State private var isShowen : Bool = false
    @State private var showAZDialogAlert : Bool = false
    @StateObject var userFinanceData : FinaceViewModel = FinaceViewModel()
    @StateObject var userWalletTransactionVm : UserWalletTransctionViewModel = UserWalletTransctionViewModel()
    let userFullCode = UserDefaultss().restoreString(key: "userFullCode")
    let constants = Constants()
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    let lang = Locale.current.languageCode
    let isDark = UserDefaultss().restoreBool(key: "isDark")
    @State private var firstInput = ""
    @State private var secondInput = ""
    @State var isLoading : Bool = false
    @State var chargeAmount : String = ""
    @State var chargeAmountDouble : Double = 0.0
    
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                    .frame(height: 350) // Adjust height as needed
                    .edgesIgnoringSafeArea(.top)
                    .cornerRadius(40, corners: [.allCorners])
                
                
                VStack(spacing:20){
                    HStack (spacing:15){
                        Image("wallet_pocket")
                            .resizable()
                            .frame(width: 50,height: 50, alignment: .center)
                        
                        Text(NSLocalizedString("wallet", comment: ""))
                            .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                            .font(
                                Font.custom(Fonts().arabic_gess_bold, size: 40)
                                    .weight(.bold)
                            )
                            .lineLimit(1)
                            .padding(.top, 10)
                          
                    }
                 
                    
                    Text(NSLocalizedString("chargedBy", comment: ""))
                        .font(
                            Font.custom(Fonts().arabic_gess_bold, size: 24)
                                .weight(.bold)
                        )
                        .lineLimit(1)
                        .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                    
                    
                    HStack (spacing:20){
                        HStack(spacing:10){
                       
                            Image("charge_by_visa")
                                .resizable()
                                .frame(width: 30,height: 30)
                            
                            Text(NSLocalizedString("visa", comment: ""))
                                .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                .font(
                                    Font.custom(Fonts().arabic_gess_bold, size: 20)
                                        .weight(.bold)
                                )
                                .lineLimit(1)
                        }
                        .onTapGesture {
                            showAZDialogAlert.toggle()
                        }
                        
                        HStack(spacing:10){
                            Image("charge_by_walletPhone")
                                .resizable()
                                .frame(width: 30,height: 30)
                            Text(NSLocalizedString("wallet", comment: ""))
                                .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                .font(
                                    Font.custom(Fonts().arabic_gess_bold, size: 20)
                                        .weight(.bold)
                                )
                                .lineLimit(1)
                        }
                        .onTapGesture {
                            showAZDialogAlert.toggle()
                        }
                        
                  
                        
                        HStack(spacing:10){
                            Image("charge_by_code")
                                .resizable()
                                .frame(width: 30,height: 30)
                            Text(NSLocalizedString("codeee", comment: ""))
                                .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                .font(
                                    Font.custom(Fonts().arabic_gess_bold, size: 20)
                                        .weight(.bold)
                                )
                                .lineLimit(1)
                        }
                        .onTapGesture {
                            showCustomCode.toggle()
                        }
                    }
                    .padding()
                    
                }
                .padding(.top,80)
                
                .background(AZDialogAlert(isPresented: $showAZDialogAlert,
                                          title: NSLocalizedString("alert", comment: ""),
                                          message: NSLocalizedString("msg_coming_soon", comment: ""),
                                          imageTop: "close_button"))
                
                VStack (spacing:30){
                    HStack {
                       
                        Image(Constants().PROJECT_LOGO)
                            .resizable()
                            .frame(width: 35,height: 35)
                            .padding(.all, 5)
                            .background(isDark ? Color(Colors().darkCardBgBlack): Color(Colors().lightCardBgWhite))
                            .cornerRadius(15, corners: .allCorners)
                        
                        
                        
                        Text(NSLocalizedString("clientName", comment: ""))
                            .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                            .font(
                                Font.custom(Fonts().arabic_gess_bold, size: 22)
                                    .weight(.bold)
                            )
                            .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    VStack {
                        BarcodeGeneratorView(barcodeString: userFullCode)
                            .frame(width: 200, height: 100)
                        
                        Text(userFullCode)
                            .kerning(5.0)
                            .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                            .font(
                                Font.custom(Fonts().arabic_gess_bold, size: 20)
                                    .weight(.bold)
                                )
                        
                        
                        
                        HStack {
                            Text(NSLocalizedString("balance", comment: ""))
                                .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                .font(
                                    Font.custom(Fonts().arabic_gess_bold, size: 20)
                                        .weight(.bold)
                                    )
                            
                            Text(DateTime.replaceCharcaterInMoney(language: self.lang!, value: userFinanceData.userFinanceStatisticData.userData?.userWalletBalanceWithCurrency ?? ""))
                                .foregroundColor(isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                .font(
                                    Font.custom(Fonts().arabic_gess_bold, size: 20)
                                        .weight(.bold)
                                    )
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                    }
                }
                
                .padding()
                .background(isDark ? Color(Colors().darkCardWalletBg): Color(Colors().lightCardWalletBg))
                .cornerRadius(10) // Set the corner radius here
                .shadow(color: isDark ? .white : .black, radius: 5, x: 0, y: 8) // Adds shadow around the VStack
                .padding()
                .frame(maxHeight: .infinity,alignment: .top)
                .offset(y:250)
//                .frame(height: 400) // Adjust this height so the image is half in and out of the purple area
            }
            
            ScrollView{
                VStack (spacing:20){
                    Spacer()
              
                    
                    VStack (spacing : 20){
                        
                        
                    }
                }
                .padding(.top,-30)
                
                Spacer()
            }
            
        }
        .onAppear(perform: {
            userFinanceData.getFinanceData()
//            userWalletTransactionVm.getUserWalletTransactionData()
        })
        .background(isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        .ipad()
        .edgesIgnoringSafeArea(.all)
       
        .toastView(toast: $toast)
        .fullScreenCover(isPresented: $backFromAboutClient, content: {
            StudentMainTabView()
        })
        .onDisappear {

        }
        
        .overlay(
            userFinanceData.isLoading ?
            GeometryReader { geometry in
                ZStack {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .transition(.scale)
                } } : nil
        )
        
        .overlay(
           isLoading ?
            GeometryReader { geometry in
                ZStack {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .transition(.scale)
                } } : nil
        )
        
        if showingCustomAlertPhone {
            PayMobWalletAlert(isPresented: $showingCustomAlertPhone,openLink : $openLink, firstInput: $firstInput, secondInput: $secondInput,isLoading:$isLoading, isPhone:true)
        }
        
        if showingCustomAlertBank {
            PayMobWalletAlert(isPresented: $showingCustomAlertBank,openLink : $openLink ,firstInput: $firstInput, secondInput: $secondInput,isLoading:$isLoading, isPhone:false)
            
        }
        if showCustomCode {
            CodeWalletAlert(routeFrom: constants.Wallet_View, isPresented: $showCustomCode, firstInput: $firstInput, isLoading: $isLoading)
        }
        
   
    }
    
}




