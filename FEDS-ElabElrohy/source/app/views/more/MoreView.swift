//
//  MoreView.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 07/04/2024.
//


import SwiftUI
@available(iOS 16.0, *)
struct MoreView: View {
    @StateObject var genralVm : GeneralVm = GeneralVm()
    @StateObject var moreVm : MoreViewModel = MoreViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                        .frame(height: 200) // Adjust height as needed
                        .edgesIgnoringSafeArea(.top)
                        .cornerRadius(40, corners: [.allCorners])
                        .onTapGesture {
                            moreVm.clearStatesWithAction(valueState: &moreVm.showMyAccountInfoFromMore)
                        }
                    
                    Text(genralVm.userName)
                        .font(
                            Font.custom(Fonts().getFontBold(), size: 32).weight(.bold))
                        .foregroundColor(Color.white)
                        .padding(.top, 55)
                    
                    Text(genralVm.phoneNumber)
                        .font(
                            Font.custom(Fonts().getFontBold(), size: 25).weight(.bold))
                        .foregroundColor(Color.white)
                        .padding(.top, 110)
                    
                    
                    VStack {
                        Spacer()
                        CircleImageUrl(imageUrl: genralVm.imageUrl
                                       , width: 100
                                       , height: 100
                                       , bgColor: genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg)
                                       , offestY: 10)
                        
                    }
                    .onTapGesture {
                        moreVm.clearStatesWithAction(valueState: &moreVm.showMyAccountInfoFromMore)
                    }
                    .frame(height: 250)
                    
                    HStack {
                        Spacer()
                        Image("hand")
                            .resizable()
                            .frame(width: 30, height: 30)
                        
                        Text(NSLocalizedString("logout", comment: ""))
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 18).weight(.bold))
                            .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                            .lineLimit(1)
                           
                    }
                    .padding()
                    .onTapGesture {
                        moreVm.clearStatesWithAction(valueState: &moreVm.showAzDialogActions)
                    }
                    .background(AzDialogActions(isPresented: $moreVm.showAzDialogActions, title: NSLocalizedString("ConfirmLogout", comment: ""), message: NSLocalizedString("msg_confirmLogout", comment: ""), imageTop: "logout_button", buttonClick: NSLocalizedString("logout", comment: ""), onClick: {
                        
                        moreVm.clearStatesWithAction(valueState: &moreVm.showRegFromMore)
                        Helper.removeUserDefaultsAndCashes()
                    }))
                    
                    .padding(.trailing, 5)
                    .offset( y: 220)
                    .frame(width: 150)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                }
                
                
                // Main content
                VStack(spacing: 4){
                    ScrollView {
                        VStack(alignment: .leading, spacing: 15) {
                            
                            if AppConstantStatus.onlineDocumentReservation {
                                
                                if ((genralVm.havePermissionToView && genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_STUDENT )
                                    || genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_FAMILY) {
                                    
                                    MenuItem(title: NSLocalizedString("reservation_form", comment: ""), icon: "Reservation_icon", bgColor: genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                        .onTapGesture(perform: {
                                            moreVm.clearStatesWithAction(valueState: &moreVm.showOnlineReservationFromMore)
                                        })
                                }
                            }
                            
                            MenuItem(title: NSLocalizedString("appSetting", comment: ""), icon: "setting_more", bgColor: genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                .onTapGesture(perform: {
                                    if moreVm.constantListData.listDateFormatType?.isEmpty == true && moreVm.constantListData.listTimeFormatType?.isEmpty == true && moreVm.constantListData.listTimeZoneInfo?.isEmpty == true {
                                        self.moreVm.getConstantList()
                                        } else {
                                        moreVm.clearStatesWithAction(valueState: &moreVm.showAppSettingsFromMore)
                                    }
                                })
                            
                            
                            if AppConstantStatus.haveAMarket {
                                
                                if ((genralVm.havePermissionToView && genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_STUDENT )
                                    || genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_FAMILY) {
                                    
                                    MenuItem(title: NSLocalizedString("market", comment: ""), icon: "closed_book", bgColor: genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                        .onTapGesture(perform: {
                                            moreVm.clearStatesWithAction(valueState: &moreVm.showMarketFromMore)

                                        })
                                }
                            }
                            
                            
                            if AppConstantStatus.certificatsAndEvaluations {
                                
                                if ((genralVm.havePermissionToView && genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_STUDENT )
                                    || genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_FAMILY) {
                                    
                                    MenuItem(title: NSLocalizedString("certificats", comment: ""), icon: "certificatsIcon", bgColor: genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                        .onTapGesture(perform: {
                                            moreVm.clearStatesWithAction(valueState: &moreVm.showCertificatsFromMore)
                                        })
                                    
                        
                                    MenuItem(title: NSLocalizedString("evaluations", comment: ""), icon: "evaluationsIcon", bgColor: genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                        .onTapGesture(perform: {
                                            moreVm.clearStatesWithAction(valueState: &moreVm.showEvaluationsFromMore)
                                        })
                                    
                                }
                            }
                                                  
                            
                            MenuItem(title:NSLocalizedString("clientName", comment: ""), icon: genralVm.constants.PROJECT_LOGO, bgColor: genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                .onTapGesture {
                                    moreVm.clearStatesWithAction(valueState: &moreVm.showContactUsFromMore)

                                }
                            
                            
                            MenuItem(title: NSLocalizedString("userCode", comment: ""), icon: "qr-code", bgColor: genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                .onTapGesture(perform: {
                                    moreVm.clearStatesWithAction(valueState: &moreVm.showUserCodeFromMore)

                                })
                            
                            if ((genralVm.havePermissionToView && genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_STUDENT )
                                || genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_FAMILY) {
                                MenuItem(title: NSLocalizedString("myWallet", comment: ""), icon: "wallet_pocket", bgColor: genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                
                                    .onTapGesture(perform: {
                                        moreVm.clearStatesWithAction(valueState: &moreVm.showWalletFromMore)

                                    })
                            }
                            
                            
                            MenuItem(title: NSLocalizedString("deleteAccount", comment: ""), icon: "delete_button", bgColor: genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                .onTapGesture(perform: {
                                    moreVm.clearStatesWithAction(valueState: &moreVm.showingAlertFromMore)

                                })
                            
                                .background(AzDialogActions(isPresented: $moreVm.showingAlertFromMore, title: NSLocalizedString("ConfirmDeletion", comment: ""), message: NSLocalizedString("msg_confirmDeletion", comment: ""), imageTop: "delete_button", buttonClick: NSLocalizedString("Delete", comment: ""), onClick: {
                                    Helper.removeUserDefaultsAndCashes()
                                    exit(0)
                                    
                                }))
                         
                            if genralVm.userTypeToken == genralVm.constants.USER_TYPE_TOKEN_FAMILY {
                                MenuItem(title: NSLocalizedString("family", comment: ""), icon: "family", bgColor: genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                
                                    .onTapGesture(perform: {
                                        moreVm.clearStatesWithAction(valueState: &moreVm.showFamliyFromMore)
                                    })
                            }
                            
                          
                       
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        
                        Spacer()
                        if AppConstantStatus.isWithBeta {
                            VStack{
                                Text(moreVm.versionNumber)
                                    .font(
                                        Font.custom(Fonts().getFontLight(), size: 25))
                                    .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                    .multilineTextAlignment(.center)
                                    .underline()
                                    .padding(.bottom, 15)
                                
                                Text(NSLocalizedString("designedAndDeveloped", comment: ""))
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 24)
                                            .weight(.bold)
                                    )
                                    .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                    .multilineTextAlignment(.center)
                                HStack(spacing: 70){
                                    Button {
                                        withAnimation(Animation
                                            .default
                                        ) {
                                            moreVm.clearStatesWithAction(valueState: &moreVm.showAboutCompanyDevFromMore)
                                        }
                                    } label: {
                                        Text(NSLocalizedString("Fahd Clo☁️d", comment: ""))
                                        
                                            .font(
                                                Font.custom(Fonts().getFontBold(), size: 22))
                                            .underline()
                                            .foregroundColor(Color.blue)
                                        
                                    }
                                    Button {
                                        withAnimation(Animation
                                            .default
                                        ) {
                                            moreVm.clearStatesWithAction(valueState: &moreVm.showBetaEduFromMore)
                                        }
                                    } label: {
                                        Text(NSLocalizedString("Beta EDU", comment: ""))
                                            .font(
                                                Font.custom(Fonts().getFontBold(), size: 22))
                                            .underline()
                                            .foregroundStyle(Color.purple)
                                    }
                                }
                                .padding(.bottom, 15)
                            }
                        }else {
                            VStack{
                                Text(moreVm.versionNumber)
                                    .font(
                                        Font.custom(Fonts().getFontLight(), size: 25))
                                    .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                    .multilineTextAlignment(.center)
                                    .underline()
                                
                                
                                Text(NSLocalizedString("copyRightFahdCloud", comment: ""))
                                    .font(
                                        Font.custom(Fonts().getFontLight(), size: 25))
                                    .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                    .multilineTextAlignment(.center)
                                    .underline()
                            }
                            .padding(.top, 30)
                            .onTapGesture {
                                moreVm.clearStatesWithAction(valueState: &moreVm.showAboutCompanyDevFromMore)
                            }
                        }
                    }
                }
                .padding(.top, 20)
                
            }
            .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
            .ipad()
            .edgesIgnoringSafeArea(.all)
            .fullScreenCover(isPresented: $moreVm.showRegFromMore, content: {
                RegistrationView()
            })
            .fullScreenCover(isPresented: $moreVm.showUserCodeFromMore, content: {
                UserCodeTabBar()
            })
            .fullScreenCover(isPresented: $moreVm.showContactUsFromMore, content: {
                AboutClientView()
            })
            .fullScreenCover(isPresented: $moreVm.showFamliyFromMore, content: {
                FamilyView()
            })
            .fullScreenCover(isPresented: $moreVm.showAppSettingsFromMore, content: {
                AppSettingView()
            })
            .fullScreenCover(isPresented: $moreVm.showAboutCompanyDevFromMore, content: {
                AboutCompanyDevelopment()
            })
            .fullScreenCover(isPresented: $moreVm.showWalletFromMore, content: {
                WalletView()
            })
            .fullScreenCover(isPresented: $moreVm.showMyAccountInfoFromMore, content: {
                ProfileView()
            })
            .fullScreenCover(isPresented: $moreVm.showOnlineReservationFromMore, content: {
                OnlineReservationDoucumentView()
            })
            .fullScreenCover(isPresented: $moreVm.showBetaEduFromMore, content: {
                BetaEduView()
            })
            .fullScreenCover(isPresented: $moreVm.showMarketFromMore, content: {
                MarketWebView()
            })
            .fullScreenCover(isPresented: $moreVm.showCertificatsFromMore, content: {
                CertificatsWebView()
            })
            .fullScreenCover(isPresented: $moreVm.showEvaluationsFromMore, content: {
                EvaluationsWebView()
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .toastView(toast: $moreVm.toast)

        .onAppear(perform: {
            if genralVm.lang == genralVm.constants.APP_IOS_LANGUAGE_AR  {
                moreVm.versionNumber = Helper.appendMultiStrings(words: "\(NSLocalizedString("Ver_Num", comment: ""))\(NSLocalizedString("circle_bracket_start", comment: "")) \(AppInfo().appVersion) \(NSLocalizedString("circle_bracket_end", comment: ""))")
                
            }else {
                moreVm.versionNumber = "\(NSLocalizedString("Ver_Num", comment: ""))\(NSLocalizedString("circle_bracket_start", comment: "")) \(AppInfo().appVersion) \(NSLocalizedString("circle_bracket_end", comment: ""))"
            }
        })
        .refreshable {
            if genralVm.lang == genralVm.constants.APP_IOS_LANGUAGE_AR  {
                moreVm.versionNumber = Helper.appendMultiStrings(words: "\(NSLocalizedString("Ver_Num", comment: ""))\(NSLocalizedString("circle_bracket_start", comment: "")) \(AppInfo().appVersion) \(NSLocalizedString("circle_bracket_end", comment: ""))")
                
            } else {
                moreVm.versionNumber = "\(NSLocalizedString("Ver_Num", comment: ""))\(NSLocalizedString("circle_bracket_start", comment: "")) \(AppInfo().appVersion) \(NSLocalizedString("circle_bracket_end", comment: ""))"
            }
        }
       
        .onDisappear {
            moreVm.clearStatesWithAction(valueState: &genralVm.dissapearView)
        }
    }
}
