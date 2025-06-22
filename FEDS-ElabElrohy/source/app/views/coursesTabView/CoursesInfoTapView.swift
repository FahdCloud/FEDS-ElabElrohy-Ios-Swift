//
//  CoursesInfoTapView.swift
//  FEDS-Dev-Ver-One
//
//  Created by Omar Pakr on 30/09/2024.
//

import SwiftUI
import BottomSheetSwiftUI

struct CoursesInfoTapView: View {
    
    @StateObject var educationCourseDetailsVm : EducationCourseDetailsVm = EducationCourseDetailsVm()
    @StateObject private var detector = ScreenRecordingDetector()
    @StateObject var studentExamVm : StudentExamVm = StudentExamVm()
    @StateObject var genralVm: GeneralVm = GeneralVm()
    
    @State private var tabs: [TabTitWithImage] = []
    @State private var currentParameter: Int = 0
    @State private var selectedTab = 0
    @State private var selectedSubscriptionPrice : Double = 0.0
    @State private var codeWalletCharged : String = ""
    @State private var codeCourseCharged : String = ""
    @State private var codeAcadmicYearCharged : String = ""
    
    @State private var showStudentMainFromMyCourses: Bool = false
    @State private var showWalletViewFromCourses = false
    @State private var showTwoWaysToBuy = false
    @State private var canBuyFromPackagePrice = false
    @State private var showingConfirmitionAlertForBuyCourse = false
    @State private var viewBuyFromWallet = false
    
    @State private var toast: Toast? = nil
    @State private var visualEffect  = VisualEffect.systemDark
    let switchablePositions: [BottomSheetPosition] = [.hidden]
    
    var body: some View {
        NavigationStack {
            VStack{
                if educationCourseDetailsVm.noData {
                    if !(educationCourseDetailsVm.isLoading) {
                        NoContent(message: educationCourseDetailsVm.msg)
                    }else {
                        NoContent(message: NSLocalizedString("loading", comment: ""), image: "loading_circles_blue_gradient")
                    }
                } else {
                    VStack {
                        HStack {
                            ForEach(tabs) { tab in
                                Button(action: {
                                    selectedTab = tabs.firstIndex(where: { $0.id == tab.id }) ?? 0
                                    saveCurrentParameterValue(for: selectedTab)
                                    loadParameterValue(for: selectedTab)
                                }) {
                                    VStack {
                                        
                                        Text(tab.title)
                                            .foregroundStyle(selectedTab == tabs.firstIndex(where: { $0.id == tab.id }) ?
                                                             (genralVm.isDark ? Color(Colors().darkMenuIconUnSelected) : Color(Colors().lightMenuIconUnSelected)) :
                                                                (genralVm.isDark ? Color(Colors().darkMenuIconSelected) : Color(Colors().lightMenuIconSelected)))
                                            .font(
                                                Font.custom(Fonts().getFontBold(), size: 20)
                                                    .weight(.bold)
                                            )
                                        
                                        // bottom line to show selected tab
                                        Rectangle()
                                            .fill(selectedTab == tabs.firstIndex(where: { $0.id == tab.id }) ?
                                                  (genralVm.isDark ? Color(Colors().darkToolbarSelected) : Color(Colors().lightToolbarSelected)) :
                                                    Color.clear)
                                            .frame(height: 5)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .background(genralVm.isDark ? Color(Colors().darkBtnMenu): Color(Colors().lightBtnMenu))
                        if !educationCourseDetailsVm.isLoading {
                            TabView(selection: $selectedTab) {
                                
                                OnlineContentLevelsView()
                                    .tag(0)
                                
                                OnlineContentViewSubscriptionView()
                                    .tag(1)
                                
                                OnlineContentHistoryView()
                                    .tag(2)
                                
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))  // Hide default page indicators
                        }
                        Spacer()
                        if ((self.educationCourseDetailsVm.educationalCourseData.educationalCourseStudentSubscriptionInfoData?.educationalCourseStudentToken == nil) || !(self.educationCourseDetailsVm.educationalCourseData.educationalCourseStudentSubscriptionInfoData?.subscriptionIsValid ??  false)){
                            ButtonAction(isWithIcon: true,
                                         iconName: "subscriptions",
                                         text: NSLocalizedString("buy", comment: ""),
                                         textSize: 20,
                                         color: genralVm.isDark ? Color(Colors().darkBtnMenu): Color(Colors().lightBtnMenu)) {
                                showTwoWaysToBuy.toggle()
                                if ( self.educationCourseDetailsVm.educationalCourseData.canBuyFromUserBalance ??  false){
                                    self.viewBuyFromWallet = true
                                }
                            }
                            
                                         .padding(.horizontal, 10)
                        }
                    }
                    
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    CustomBackButton(){
                        clearStatesWithAction(valueState: &showStudentMainFromMyCourses)
                    }
                }
            }
        }
        .ignoresSafeArea()
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        .ipad()
        .toastView(toast: $toast)
        .background(AzDialogActions(isPresented: $showingConfirmitionAlertForBuyCourse, title: NSLocalizedString("ConfirmBuying", comment: ""), message: NSLocalizedString("msg_confirmBuying", comment: ""), imageTop: "buy_icon", buttonClick: NSLocalizedString("buy", comment: ""), onClick: {
            educationCourseDetailsVm.buyCourseFromBalance(educationalCourseData: educationCourseDetailsVm.educationalCourseData)
            
        }))
        
        .bottomSheet(
            bottomSheetPosition: $educationCourseDetailsVm.bottomSheetPositionPackagePrice,
            switchablePositions: switchablePositions,
            headerContent: {},
            mainContent: {
                
                VStack(alignment: .center){
                    
                    HStack(spacing:50){
                        
                        VStack {
                            Text(NSLocalizedString("packagesPrice", comment: ""))
                            
                                .foregroundColor(Color.white)
                                .font (
                                    Font.custom(Fonts().getFontBold(), size: 24)
                                        .weight(.bold)
                                )
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                            
                            Text(NSLocalizedString("chooseSubscriptionType", comment: ""))
                            
                                .foregroundColor(Color.white)
                                .font (
                                    Font.custom(Fonts().getFontBold(), size: 18)
                                        .weight(.bold)
                                )
                                .underline()
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                        }
                        
                        Image("subscriptions")
                            .resizable()
                            .frame(width: 80, height: 80, alignment: .center)
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    .background(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                    
                    
                    VStack{
                        ForEach(0..<(educationCourseDetailsVm.educationalCourseData.educationalCourseSubscriptionPlans?.count ?? 0), id: \.self) { index in
                            VStack {
                                HStack {
                                    if self.genralVm.lang == self.genralVm.constants.APP_LANGUAGE_AR {
                                        
                                        Text(" - " + (educationCourseDetailsVm.educationalCourseData.educationalCourseSubscriptionPlans?[index].subscriptionPlanNameAr ?? ""))
                                    } else {
                                        Text(" - " + (educationCourseDetailsVm.educationalCourseData.educationalCourseSubscriptionPlans?[index].subscriptionPlanNameEn ?? ""))
                                    }
                                    
                                    Spacer()
                                    
                                    Image("wallet-2")
                                        .resizable()
                                        .frame(width: 35, height: 35, alignment: .center)
                                        
                                }
                                .padding()
                                .onTapGesture {
                                    self.selectedSubscriptionPrice = (educationCourseDetailsVm.educationalCourseData.educationalCourseSubscriptionPlans?[index].subscriptionPrice ?? 0.0)
                                    
                                    if (educationCourseDetailsVm.userFinanceStatisticData.userData?.userWalletBalance !=  nil){
                                        let walletBalance : Double = educationCourseDetailsVm.userFinanceStatisticData.userData?.userWalletBalance! ?? 0.0
                                        
                                        if walletBalance >= self.selectedSubscriptionPrice {
                                            clearStatesWithAction(valueState: &showingConfirmitionAlertForBuyCourse)
                                        } else{
                                            clearStatesWithAction(valueState: &showWalletViewFromCourses)
                                        }
                                    }
                                   
                                }
                                Divider()
                                    .background(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                                
                            }
                            .padding(.top,10)
                            .padding(.bottom,10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 18)
                                    .weight(.bold)
                            )
                        }
                    }
                }
                .padding(.all, 15)
            }
        )
        .enableSwipeToDismiss(true)
        .enableTapToDismiss(true)
        .enableBackgroundBlur(true)
        .enableContentDrag(true)
        .backgroundBlurMaterial(visualEffect)
        
        
        .bottomSheet(
            bottomSheetPosition: $educationCourseDetailsVm.bottomSheetPositionWalletCode,
            switchablePositions: switchablePositions,
            headerContent: {},
            mainContent: {
                
                VStack{
                    
                    HStack(spacing:10){
                        Image("charge_by_code")
                            .resizable()
                            .frame(width: 50,height: 50)
                        Text(NSLocalizedString("wallet_code", comment: ""))
                            .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 40)
                                    .weight(.bold)
                            )
                            .lineLimit(1)
                    }
                    .frame(alignment: .center)
                    .padding()
                    
                    TextField("", text: $codeWalletCharged)
                        .textFieldStyle(
                            CustomTextField(placeholder: NSLocalizedString("codeee", comment: ""),
                                            textColor: genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText),
                                            placeholderColor: genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText),
                                            placeholderBgColor: genralVm.isDark ? Color(Colors().darkBodyBg):
                                                Color(Colors().lightBodyBg),
                                            image: "charge_by_code",
                                            isEditing: !self.codeWalletCharged.isEmpty)
                        )
                        .keyboardType(.numberPad)
                        .onChange(of: codeWalletCharged) { newValue in
                            guard !newValue.isEmpty else { return }
                            let sanitizedText = Helper.sanitizeInput(newValue)
                            if sanitizedText != newValue {
                                codeWalletCharged = sanitizedText
                            }
                        }
                    
                    HStack{
                        ButtonAction(text:NSLocalizedString("cancel", comment: ""), color: .red) {
                            educationCourseDetailsVm.bottomSheetPositionWalletCode = .hidden
                        }
                        
                        ButtonAction(text:NSLocalizedString("charge", comment: ""), color: .green) {
                            educationCourseDetailsVm.buyCourseFromWalletCode(educationalCourseData: educationCourseDetailsVm.educationalCourseData, code: codeWalletCharged)
                        }
                    }
                    
                }
                .padding(.all, 15)
                
            }
            
        )
        .enableSwipeToDismiss(false)
        .enableTapToDismiss(true)
        .enableBackgroundBlur(true)
        .enableContentDrag(true)
        .backgroundBlurMaterial(visualEffect)
        
        
        .bottomSheet(
            bottomSheetPosition: $educationCourseDetailsVm.bottomSheetPositionAcadmicYearCode,
            switchablePositions: switchablePositions,
            headerContent: {},
            mainContent: {
                
                VStack{
                    
                    HStack(spacing:10){
                        Image("charge_by_code")
                            .resizable()
                            .frame(width: 50,height: 50)
                        Text(NSLocalizedString("acadmicYear_code", comment: ""))
                            .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 28)
                                    .weight(.bold)
                            )
                            .lineLimit(1)
                    }
                    .frame(alignment: .center)
                    .padding()
                    
                    TextField("", text: $codeAcadmicYearCharged)
                        .textFieldStyle(
                            CustomTextField(placeholder: NSLocalizedString("codeee", comment: ""),
                                            textColor: genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText),
                                            placeholderColor: genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText),
                                            placeholderBgColor: genralVm.isDark ? Color(Colors().darkBodyBg):
                                                Color(Colors().lightBodyBg),
                                            image: "charge_by_code",
                                            isEditing: !self.codeAcadmicYearCharged.isEmpty)
                        )
                        .onChange(of: codeAcadmicYearCharged) { newValue in
                            guard !newValue.isEmpty else { return }
                            let sanitizedText = Helper.sanitizeInput(newValue)
                            if sanitizedText != newValue {
                                codeAcadmicYearCharged = sanitizedText
                            }
                        }
                    
                    HStack{
                        ButtonAction(text:NSLocalizedString("cancel", comment: ""), color: .red) {
                            educationCourseDetailsVm.bottomSheetPositionAcadmicYearCode = .hidden
                        }
                        
                        ButtonAction(text:NSLocalizedString("charge", comment: ""), color: .green) {
                            educationCourseDetailsVm.buyCourseFromAcademicYearCode(educationalCourseData: educationCourseDetailsVm.educationalCourseData, code: codeAcadmicYearCharged)
                        }
                    }
                    
                }
                .padding(.all, 15)
                
            }
            
        )
        .enableSwipeToDismiss(false)
        .enableTapToDismiss(true)
        .enableBackgroundBlur(true)
        .enableContentDrag(true)
        .backgroundBlurMaterial(visualEffect)
        
        
        .bottomSheet(
            bottomSheetPosition: $educationCourseDetailsVm.bottomSheetPositionCourseCode,
            switchablePositions: switchablePositions,
            headerContent: {},
            mainContent: {
                
                VStack{
                    
                    HStack(spacing:10){
                        Image("charge_by_code")
                            .resizable()
                            .frame(width: 50,height: 50)
                        Text(NSLocalizedString("course_code", comment: ""))
                            .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 40)
                                    .weight(.bold)
                            )
                            .lineLimit(1)
                    }
                    .frame(alignment: .center)
                    .padding()
                    
                    TextField("", text: $codeCourseCharged)
                        .textFieldStyle(
                            CustomTextField(placeholder: NSLocalizedString("codeee", comment: ""),
                                            textColor: genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText),
                                            placeholderColor: genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText),
                                            placeholderBgColor: genralVm.isDark ? Color(Colors().darkBodyBg):
                                                Color(Colors().lightBodyBg),
                                            image: "charge_by_code",
                                            isEditing: !self.codeCourseCharged.isEmpty)
                        )
                        .keyboardType(.numberPad)
                        .onChange(of: codeCourseCharged) { newValue in
                            guard !newValue.isEmpty else { return }
                            let sanitizedText = Helper.sanitizeInput(newValue)
                            if sanitizedText != newValue {
                                codeCourseCharged = sanitizedText
                            }
                        }
                    
                    HStack{
                        ButtonAction(text:NSLocalizedString("cancel", comment: ""), color: .red) {
                            educationCourseDetailsVm.bottomSheetPositionCourseCode = .hidden
                        }
                        
                        ButtonAction(text:NSLocalizedString("charge", comment: ""), color: .green) {
                            
                            educationCourseDetailsVm.buyCourseFromCourseCode(educationalCourseData: educationCourseDetailsVm.educationalCourseData, code: codeCourseCharged)
                            
                            
                        }
                    }
                    
                }
                .padding(.all, 15)
                
            }
            
        )
        .enableSwipeToDismiss(false)
        .enableTapToDismiss(true)
        .enableBackgroundBlur(true)
        .enableContentDrag(true)
        .backgroundBlurMaterial(visualEffect)
        
        
        .onAppear {
            UserDefaultss().removeObject(forKey: "examParagraphsInfoData")
            setupTabs()
            loadParameterValue(for: selectedTab)
            educationCourseDetailsVm.getEducationCourseDetails(token: self.genralVm.courseToken)
        }
        .overlay(
            educationCourseDetailsVm.isLoading ?
            GeometryReader { geometry in
                ZStack {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .transition(.scale)
                } } : nil
        )
        .background(AzDialogWithTwoActions(isPresented: $showTwoWaysToBuy,
                                           dismissAzDialogActions: true,
                                           title: NSLocalizedString("alert", comment: ""),
                                           message: NSLocalizedString("Choose your way to buy", comment: ""),
                                           imageTop: "subscriptions",
                                           StartActionText: NSLocalizedString("By Codes", comment: ""),
                                           EndActionText: NSLocalizedString("By Wallet", comment: ""),
                                           StartActionClick: {
            if (educationCourseDetailsVm.educationalCourseData.educationalCourseNaturePurchaseType == genralVm.constants.CoursePurchaseType_CourseCode){
                self.codeCourseCharged.removeAll()
                educationCourseDetailsVm.bottomSheetPositionCourseCode = .dynamic
                
            } else if (educationCourseDetailsVm.educationalCourseData.educationalCourseNaturePurchaseType == genralVm.constants.CoursePurchaseType_WalletCode){
                self.codeWalletCharged.removeAll()
                educationCourseDetailsVm.bottomSheetPositionWalletCode = .dynamic
                
            } else if (educationCourseDetailsVm.educationalCourseData.educationalCourseNaturePurchaseType == genralVm.constants.CoursePurchaseType_AcademicYearCode){
                self.codeAcadmicYearCharged.removeAll()
                educationCourseDetailsVm.bottomSheetPositionAcadmicYearCode = .dynamic
                
            }
            
        },
        EndActionClick: {
            if (self.educationCourseDetailsVm.educationalCourseData.educationalCourseSubscriptionPlans?.count ?? 0 <= 0 ){
                self.toast = Helper.showToast(style: .error, message: NSLocalizedString("msg_empty_subscription_plans", comment: ""))
            
            }else{
                educationCourseDetailsVm.getFinanceData()
                educationCourseDetailsVm.bottomSheetPositionPackagePrice = .dynamic
        }
            
        }, viewEndActionBtn : viewBuyFromWallet
                                          ))
        
        .refreshable {
            educationCourseDetailsVm.getEducationCourseDetails(token: self.genralVm.courseToken)
        }
        .onDisappear {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $showStudentMainFromMyCourses, content: {
            StudentMainTabView()
        }) 
        .fullScreenCover(isPresented: $educationCourseDetailsVm.showCourseInfoTabView, content: {
            CoursesInfoTapView()
        })
        .fullScreenCover(isPresented: $showWalletViewFromCourses, content: {
            WalletView()
        })
        
    }
    
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        showStudentMainFromMyCourses = false
        showWalletViewFromCourses = false
        showTwoWaysToBuy = false
        canBuyFromPackagePrice = false
        showingConfirmitionAlertForBuyCourse = false
        viewBuyFromWallet = false
        
    }
    private func saveCurrentParameterValue(for tab: Int) {
        UserDefaultss().saveInt(value: tab, key: "currentTabCoursesInfo")
    }
    
    private func loadParameterValue(for tab: Int) {
        currentParameter = UserDefaultss().restoreInt(key: "currentTabCoursesInfo")
    }
    
    private func setupTabs() {
        tabs = [
            TabTitWithImage(title: NSLocalizedString("content", comment: "")),
            TabTitWithImage(title: NSLocalizedString("info", comment: "")),
            TabTitWithImage(title: NSLocalizedString("history", comment: ""))
        ]
        
        
    }
    
    
}
