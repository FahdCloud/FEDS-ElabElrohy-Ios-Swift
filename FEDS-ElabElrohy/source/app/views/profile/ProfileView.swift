//
//  MyAccountInfoView.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 17/04/2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct ProfileView: View {
    @StateObject var userFinanceVm : FinaceViewModel = FinaceViewModel()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    @State private var backFromProfileInfo : Bool = false
    @State private var showChangePassFromProfileInfo : Bool = false
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Image("student")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(genralVm.isDark ? .black: .white)
                    
                    Text(NSLocalizedString("myAccount", comment: ""))
                        .font(
                            Font.custom(Fonts().getFontBold(), size: 30).weight(.bold))
                        .foregroundColor(genralVm.isDark ? .white: .black)
                }
                .padding(.top, 10)
                
                ZStack(alignment: .top) {
                    
                    VStack {
                        VStack(alignment: .leading){
                            HStack{
                                Image("student")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                
                                Text(genralVm.userName)
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 20).weight(.bold))
                                    .foregroundColor(genralVm.isDark ? .white: .black)
                                
                            }
                            
                            Divider()
                                .bold()
                            if ((genralVm.havePermissionToView && genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_STUDENT )
                                || genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_FAMILY) {
                                
                            HStack{
                                Image("charge_by_walletPhone")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                
                                Text(genralVm.phoneNumber)
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 20).weight(.bold))
                                    .foregroundColor(genralVm.isDark ? .white: .black)
                                
                            }
                            
                            Divider()
                            
                                HStack{
                                    Image("wallet_pocket")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                    
                                    Text(DateTime.replaceCharcaterInMoney(language: self.genralVm.lang, value: userFinanceVm.userFinanceStatisticData.userData?.userWalletBalanceWithCurrency ?? ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 20).weight(.bold))
                                        .foregroundColor(genralVm.isDark ? .white: .black)
                                    
                                }
                                Divider()
                            }
                        }
                        .padding(.horizontal, 15)
                        VStack(alignment: .center){
                            BarcodeGeneratorView(barcodeString: genralVm.userFullCode)
                                .frame(width: 200, height: 100)
                            
                            Text(genralVm.userFullCode)
                                .kerning(5.0)
                                .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 20)
                                        .weight(.bold)
                                )
                        }
                        .padding(.top, 50)
                        
                    }
                    .frame(height: 500)
                    .background(genralVm.isDark ? Color(Colors().darkCardWalletBg): Color(Colors().lightCardWalletBg))
                    .cornerRadius(10) // Set the corner radius here
                    .shadow(color: genralVm.isDark ? .white : .black, radius: 5, x: 0, y: 8)
                    .frame(maxHeight: .infinity,alignment: .top)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    
                    CircleImageUrl(imageUrl: genralVm.imageUrl
                                   , width: 170
                                   , height: 170
                                   , bgColor: genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg)
                                   , offestY: -100)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                }
                .padding(.top, 120)
                            
                VStack(alignment: .trailing){
                    HStack{
                        Image("lock")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        Text(NSLocalizedString("changePassword", comment: ""))
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 18).weight(.bold))
                            .foregroundColor(genralVm.isDark ? .white: .black)
                    }
                }
                .padding(.top, 80)
                .onTapGesture {
                    clearStatesWithAction(valueState: &showChangePassFromProfileInfo)
                }
            }
            .onAppear {
                userFinanceVm.getFinanceData()
            }
        }
        .refreshable {
            userFinanceVm.getFinanceData()
        }
        .fullScreenCover(isPresented: $backFromProfileInfo, content: {
            StudentMainTabView()
        })
         .fullScreenCover(isPresented: $showChangePassFromProfileInfo, content: {
            ChangePasswordView()
        })
        
         .fullScreenCover(isPresented: $userFinanceVm.showLogOut, content: {
            RegistrationView()
        })
         .onDisappear(perform: {
             clearStatesWithAction(valueState: &genralVm.dissapearView)
         })
         .overlay(
            userFinanceVm.isLoading ?
             GeometryReader { geometry in
                 ZStack {
                     LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                         .frame(width: geometry.size.width, height: geometry.size.height)
                         .transition(.scale)
                 } } : nil
         )
        
        .gesture(
            DragGesture()
                .onEnded { value in
                    // Check if the drag was towards the left
                    if value.translation.width < 0 {
                        // Perform your action here
                        clearStatesWithAction(valueState: &backFromProfileInfo)
                    }else if value.translation.width > 0 {
                        clearStatesWithAction(valueState: &backFromProfileInfo)
                    }
                }
        )
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        backFromProfileInfo = false
        showChangePassFromProfileInfo = false
      }
}
