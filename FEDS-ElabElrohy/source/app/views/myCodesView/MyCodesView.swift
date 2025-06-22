//
//  MyCodesView.swift
//  FEDS-Center-Dev
//
//  Created by Omar pakr on 25/01/2024.
//


import SwiftUI
import UniformTypeIdentifiers


@available(iOS 16.0, *)
struct MyCodesView: View {
    @StateObject var myCodeVm : MyCodeVm = MyCodeVm()
    @StateObject var teacherCodeAvailableStatVm : TeachersCodeStatisticsVm = TeachersCodeStatisticsVm()
    @StateObject var genralVm : GeneralVm = GeneralVm()

    
    let columns = [ GridItem(.fixed(400), spacing: 30)]
    
    @Environment(\.refresh) private var refreshAction
    @State private var refresh: Bool = false
    @State private var showDetails: Bool = false
    @State private var showAlert: Bool = false
    @State private var showRegFromMyCodes: Bool = false
    @State private var isLoading: Bool = false
    @State private var showStudentMainFromMyCodes : Bool = false
    @State private var codePrice: Double = 0.0
    
    var isFromMore : Bool
    var userProviderToken = UserDefaultss().restoreString(key: "userProviderToken")
    
    @State private var toast: Toast? = nil
    var body: some View {
        NavigationView {
            ZStack {
                if myCodeVm.noData {
                    NoContent(message: myCodeVm.msg)
                } else {
                    VStack {
                        ScrollView {
                            LazyVGrid(columns: columns,spacing: 10) {
                                ForEach(myCodeVm.teacherCode,id:\.teacherCodeToken) { code in
                                    VStack {
                                        VStack {
                                            Text(code.codeText ?? "")
                                                .font(
                                                  Font.custom(Fonts().getFontBold(), size: 22)
                                                    .weight(.bold)
                                                )
                                                .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                                .multilineTextAlignment(.center)
                                                .lineLimit(1)
                                            
                                           
                                            
                                            HStack(spacing:100) {
                                                HStack (spacing:10) {
                                                    Image("lecture")
                                                        .resizable()
                                                        .frame(width: 30, height: 30)
                                                    
                                                    Text(code.userServiceProviderInfoData?.userNameCurrent ?? "")
                                                        .font(
                                                            Font.custom(Fonts().getFontBold(), size: 18)
                                                                .weight(.bold)
                                                        )
                                                        .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(1)
                                                    
                                                    
                                                }
                                                HStack (spacing:10) {
                                                    Image("finance_pocket")
                                                        .resizable()
                                                        .frame(width: 30, height: 30)
                                                    
                                                    Text(code.codePriceWithCurrency ?? "")
                                                        .font(
                                                            Font.custom(Fonts().getFontBold(), size: 18)
                                                                .weight(.bold)
                                                        )
                                                        .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(1)
                                                    
                                                    
                                                }
                                            }
                                        }
                                        .padding()
                                        .frame(maxWidth:.infinity)
                                        .background(genralVm.isDark ? Color(Colors().darkCardBgText): Color(Colors().lightCardBgText))
                                        .cornerRadius(12)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 5)
                                        
                                        HStack {
                                            HStack (spacing:5){
                                                if code.saleStatusTypeToken! == genralVm.constants.SALE_STATUS_TYPE_TOKEN_ERROR {
                                                    Text(NSLocalizedString("notAvailable", comment: ""))
                                                        .foregroundColor(.red)
                                                } else {
                                                    Text(NSLocalizedString("available", comment: ""))
                                                        .foregroundColor(.green)
                                                }
                                            }
                                            
                                            Spacer()
                                            
                                            HStack (spacing:5){
                                                if (code.saleStatusTypeToken! == genralVm.constants.SALE_STATUS_TYPE_TOKEN_SALED) {
                                                    HStack {
                                                        Text(code.teacherCodeSellingInfoData?.sellingDate ?? "")
                                                        Text(" - ")
                                                        Text(code.teacherCodeSellingInfoData?.sellingTime ?? "")
                                                    }
                                                } else if (code.saleStatusTypeToken! == genralVm.constants.SALE_STATUS_TYPE_TOKEN_ERROR) {
                                                    HStack {
                                                        Text(code.teacherCodeRefundInfoData?.refundDate ?? "")
                                                        Text(" - ")
                                                        Text(code.teacherCodeRefundInfoData?.refundTime ?? "")
                                                    }
                                                }
                                            }
                                            .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText) : Color(Colors().lightBodyText))

                                        }
                                        .padding()
                                        
                                        Rectangle()
                                            .fill(genralVm.isDark ? .white : .black)
                                            .frame(height: 3)
                                            .frame(maxWidth:.infinity)
                                            .edgesIgnoringSafeArea(.horizontal)
                                        
                                    }
                                    .onTapGesture {
                                        UIPasteboard.general.setValue(code.codeText ?? "",
                                                                      forPasteboardType: UTType.plainText.identifier)
                                        toast = Helper.showToast(style: .success, message: NSLocalizedString("textCopied", comment: ""))
                                    }
                                }
                            }
                            .padding()
                        }
                        
                        
                    }
                }
            }
            .navigationTitle(NSLocalizedString("myCode", comment: ""))
            .navigationBarItems(leading: CustomBackButton(){
                clearStatesWithAction(valueState: &showStudentMainFromMyCodes)
            })
            .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
            .ipad()
            
            .overlay(
                myCodeVm.isLoading ?
                GeometryReader { geometry in
                    ZStack {
                        LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .transition(.scale)
                    } } : nil
            )
            
            .refreshable {
                myCodeVm.getTeacherCode()
            }
            .onAppear {
                myCodeVm.getTeacherCode()
            }
            
            .fullScreenCover(isPresented: $myCodeVm.logOut, content: {
                RegistrationView()
            })
            
            .fullScreenCover(isPresented: $showStudentMainFromMyCodes, content: {
                    StudentMainTabView()
            })
            .onDisappear(perform: {
                clearStatesWithAction(valueState: &genralVm.dissapearView)
            })
            .toastView(toast: $toast)
        }
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showStudentMainFromMyCodes = false
        showRegFromMyCodes = false
    }
    
    private func loadMoreContentIfNeeded(currentItem code: TeacherCodesDatum) {
        guard !myCodeVm.isLoading, let lastCode = myCodeVm.teacherCode.last, lastCode.teacherCodeToken == code.teacherCodeToken else { return }
        myCodeVm.isLoading = true
        myCodeVm.currentPage += 1
        loadMoreContent()
    }
    
    private func loadMoreContent() {
        myCodeVm.getTeacherCode()
    }
    func requestCode(userProviderToken : String , teacherCodePrice : Double ){
        isLoading = true
        
        do {
            try Api().buyTeacherCode(userAuthorizeToken: self.genralVm.authToken, userServiceProviderToken: userProviderToken, teacherCodePrice: teacherCodePrice) { status, msg in
                
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    self.isLoading = false
                    toast = Helper.showToast(style: .success, message: msg)
                    
                } else if status == self.genralVm.constants.STATUS_INVALID_TOKEN {
                    self.isLoading = false
                    toast = Helper.showToast(style: .error, message: msg)
                    
                }else {
                    self.isLoading = false
                    toast = Helper.showToast(style: .error, message: msg)
                }
            }
        } catch {
            self.isLoading = false
            toast = Helper.showToast(style: .error, message: error.localizedDescription)
            
        }
    }
    
}
