//
//  LectureCodes.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 22/04/2024.
//

import SwiftUI

@available(iOS 16.0, *)
struct CategoriesLecturersCodesView: View {
    @StateObject var teacherCodeAvailableStatVm : TeachersCodeStatisticsVm = TeachersCodeStatisticsVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    let columns = [ GridItem(.fixed(140), spacing: 4),
                    GridItem(.fixed(140), spacing: 4),
                    GridItem(.fixed(140), spacing: 4)]

    @Environment(\.refresh) private var refreshAction
    @State private var refresh: Bool = false
    @State private var showLecturersFromLecturerCodes: Bool = false
    @State private var showAlertBuyCode: Bool = false
    
    @State private var codePrice: Double = 0.0
    var userProviderToken = UserDefaultss().restoreString(key: "userProviderToken")

    @State private var toast: Toast? = nil
    
    
    var body: some View {
        NavigationView {
            ZStack {
                if teacherCodeAvailableStatVm.noData {
                    NoContent(message: teacherCodeAvailableStatVm.msg)
                }
                else {
                    VStack {
                        ScrollView {
                            LazyVGrid(columns: columns,spacing: 5) {
                                ForEach(teacherCodeAvailableStatVm.teacherCodeAvailablePricesStatistic,id:\.price) { code in
                                    HStack (spacing:10) {
                                        Image("vec_money_1")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                        
                                        Text(code.priceWithCurrency ?? "")
                                            .font(
                                                Font.custom(Fonts().getFontBold(), size: 14)
                                                    .weight(.bold)
                                            )
                                            .multilineTextAlignment(.center)
                                            .lineLimit(1)
                                            .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                            .padding(.vertical, 20)
                                                    
                                    }
                                    .frame(maxWidth:.infinity)
                                    .background(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                    .cornerRadius(5)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 10)
                                    .onTapGesture(perform: {
                                        showAlertBuyCode.toggle()
                                        self.codePrice = code.price ?? 0.0
                                    })
                                }
                            }
                        }
                        .refreshable {
                            teacherCodeAvailableStatVm.getTeacherCodeAvailablePricesStatistic(userServiceProviderToken:self.userProviderToken)
                        }
                      
                    }
                }
                
            }
            .background(AzDialogActions(isPresented: $showAlertBuyCode
                                            , dismissAzDialogActions:true,
                                              dismissAzDialogDirection: .both,
                                              showDismissButton: true, title: NSLocalizedString("alert", comment: ""), message: NSLocalizedString("sureToBuyCode", comment: ""), imageTop: "money_icon", buttonClick: NSLocalizedString("confirm", comment: ""), onClick: {
                teacherCodeAvailableStatVm.requestCode(userProviderToken: self.userProviderToken, teacherCodePrice: self.codePrice)
                                                  
                                              }))
            .onAppear {
                teacherCodeAvailableStatVm.getTeacherCodeAvailablePricesStatistic(userServiceProviderToken:self.userProviderToken)
            }
            .navigationTitle(NSLocalizedString("teacherCode", comment: ""))
            .navigationBarItems(leading: CustomBackButton(){
                clearStatesWithAction(valueState: &showLecturersFromLecturerCodes)
            })
            
            .overlay(
                teacherCodeAvailableStatVm.isLoading ?
                GeometryReader { geometry in
                    ZStack {
                        LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .transition(.scale)
                    } } : nil
            )
            .onDisappear(perform: {
                clearStatesWithAction(valueState: &genralVm.dissapearView)
            })
            .fullScreenCover(isPresented: $teacherCodeAvailableStatVm.showLogOut, content: {
                RegistrationView()
            })
            .fullScreenCover(isPresented: $showLecturersFromLecturerCodes, content: {
                CatergoriesHomeView()
            })
        }
        
        .toastView(toast: $teacherCodeAvailableStatVm.toast)
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        .ipad()
    }
    private func clearStatesWithAction(valueState: inout Bool) {
            valueState.toggle()
        showLecturersFromLecturerCodes = false
        }
}
