
//
//  WalletView.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 27/03/2024.
//

import SwiftUI
import BottomSheetSwiftUI
import Combine


@available(iOS 16.0, *)
struct WalletView: View {
    @StateObject private var keyboard = KeyboardResponder()
    @StateObject var genralVm : GeneralVm = GeneralVm()
    @StateObject var financeVm : FinaceViewModel = FinaceViewModel()
    @StateObject var userWalletTransactionVm : UserWalletTransctionViewModel = UserWalletTransctionViewModel()
    
    @State private var toast: Toast? = nil
    @State private var isPresented : Bool = false
    @State private var showingCustomAlertPhone : Bool = false
    @State private var showingCustomAlertBank : Bool = false
    @State private var showCustomCode : Bool = false
    @State private var showPassword : Bool = false
    @State private var showHome : Bool = false
    @State private var openLink : Bool = false
    @State private var isShowen : Bool = false
    @State private var showAZDialogAlert : Bool = false
    @State private var backFromWallet : Bool = false
    @State private var firstInput = ""
    @State private var secondInput = ""
    
    
    @State private var visualEffect  = VisualEffect.systemDark
    let switchablePositions: [BottomSheetPosition] = [.dynamic]
    let userFullCode = UserDefaultss().restoreString(key: "userFullCode")
    
    
    @State private var chargeAmount : String = ""
    @State private var chargeAmountDouble : Double = 0.0
    
    
    @EnvironmentObject var screenshotDetector: ScreenshotDetector
    @EnvironmentObject var screenRecordingDetector: ScreenRecordingDetector
    @StateObject private var detector = ScreenRecordingDetector()
    
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(genralVm.isDark ? Color(Colors().darkCardBg): Color(Colors().lightCardBg))
                    .frame(height: 350) // Adjust height as needed
                    .edgesIgnoringSafeArea(.top)
                    .cornerRadius(40, corners: [.allCorners])
                
                
                VStack(spacing:20){
                    HStack (spacing:15){
                        Image("wallet_pocket")
                            .resizable()
                            .frame(width: 50,height: 50, alignment: .center)
                        
                        Text(NSLocalizedString("wallet", comment: ""))
                            .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 40)
                                    .weight(.bold)
                            )
                            .lineLimit(1)
                            .padding(.top, 10)
                        
                    }
                    Text(NSLocalizedString("chargedBy", comment: ""))
                        .font(
                            Font.custom(Fonts().getFontBold(), size: 24)
                                .weight(.bold)
                        )
                        .lineLimit(1)
                        .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                    
                    
                    HStack (spacing:20){
                        
                        if AppConstantStatus.payMob {
                            HStack(spacing:10){
                                
                                Image("charge_by_visa")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                
                                Text(NSLocalizedString("visa", comment: ""))
                                    .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 20)
                                            .weight(.bold)
                                    )
                                    .lineLimit(1)
                            }
                            .onTapGesture {
                                financeVm.bottomSheetPositionWalletVisa = .dynamic
                            }
                            
                            HStack(spacing:10){
                                Image("charge_by_walletPhone")
                                    .resizable()
                                    .frame(width: 30,height: 30)
                                Text(NSLocalizedString("wallet", comment: ""))
                                    .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                    .font(
                                        Font.custom(Fonts().getFontBold(), size: 20)
                                            .weight(.bold)
                                    )
                                    .lineLimit(1)
                            }
                            .onTapGesture {
                                financeVm.bottomSheetPositionWalletPhone = .dynamic
                                //                            showAZDialogAlert.toggle()
                            }
                        }
                        
                        
                        HStack(spacing:10){
                            Image("charge_by_code")
                                .resizable()
                                .frame(width: 30,height: 30)
                            Text(NSLocalizedString("codeee", comment: ""))
                                .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 20)
                                        .weight(.bold)
                                )
                                .lineLimit(1)
                        }
                        .onTapGesture {
                            financeVm.bottomSheetPositionWalletCode = .dynamic
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
                        
                        Image(genralVm.constants.PROJECT_LOGO)
                            .resizable()
                            .frame(width: 35,height: 35)
                            .padding(.all, 5)
                            .background(genralVm.isDark ? Color(Colors().darkCardBgBlack): Color(Colors().lightCardBgWhite))
                            .cornerRadius(15, corners: .allCorners)
                        
                        
                        
                        Text(NSLocalizedString("clientName", comment: ""))
                            .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 22)
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
                            .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                            .font(
                                Font.custom(Fonts().getFontBold(), size: 20)
                                    .weight(.bold)
                            )
                        
                        
                        
                        HStack {
                            Text(NSLocalizedString("balance", comment: ""))
                                .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 20)
                                        .weight(.bold)
                                )
                            
                            Text(DateTime.replaceCharcaterInMoney(language: self.genralVm.lang, value: financeVm.userFinanceStatisticData.userData?.userWalletBalanceWithCurrency ?? ""))
                                .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 20)
                                        .weight(.bold)
                                )
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 10)
                    }
                    
                    
                }
                
                .padding()
                .background(genralVm.isDark ? Color(Colors().darkCardWalletBg): Color(Colors().whiteColorWithTrans))
                .cornerRadius(10) // Set the corTableHeaderViewner radius here
                .shadow(color: genralVm.isDark ? .white : .black, radius: 5, x: 0, y: 8) // Adds shadow around the VStack
                .padding()
                .frame(maxHeight: .infinity,alignment: .top)
                .offset(y:250)
                
                
                VStack {
                    if userWalletTransactionVm.noData {
                        NoContent(message: userWalletTransactionVm.msg)
                            .navigationTitle(NSLocalizedString("courses", comment: ""))
                    } else {
                        List {
                            Section(header: TableHeaderView) {
                                ForEach(Array(userWalletTransactionVm.userWalletTransactionData.enumerated()), id: \.element.userWalletTransactionToken) { index, walletTransactionData in
                                    HStack {
                                        Text("\(index + 1)")
                                            .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                            .font(
                                                Font.custom(Fonts().getFontLight(), size: 14)
                                                    .weight(.bold)
                                            )
                                            .lineLimit(1)
                                            .frame(minWidth: 50) // Optional: Set minimum width for number column
                                        Text(walletTransactionData.userWalletTransactionValueWithCurreny ?? "" )
                                            .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                            .font(
                                                Font.custom(Fonts().getFontLight(), size: 16)
                                                    .weight(.bold)
                                            )
                                            .lineLimit(1)
                                            .frame(minWidth: 100) // Optional: Set minimum width for price column
                                        Text("\(walletTransactionData.creationDate ?? "") - \(walletTransactionData.creationTime ?? "")")
                                            .foregroundColor(genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText))
                                            .font(
                                                Font.custom(Fonts().getFontLight(), size: 14)
                                                    .weight(.bold)
                                            )
                                    }
                                }
                            }
                        }
                        
                    }
                }
                .padding(.vertical, 5)
                .padding(.horizontal,3)
                .offset(y:550)
                .frame( alignment: .center)
            }
            
            .bottomSheet(
                bottomSheetPosition: $financeVm.bottomSheetPositionWalletPhone,
                switchablePositions: switchablePositions,
                headerContent: {},
                mainContent: {
                    
                    VStack{
                        
                        HStack(spacing:10){
                            Image("wallet_pocket")
                                .resizable()
                                .frame(width: 50,height: 50)
                            Text(NSLocalizedString("wallet", comment: ""))
                                .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 40)
                                        .weight(.bold)
                                )
                                .lineLimit(1)
                        }
                        .frame(alignment: .center)
                        .padding()
                        
                        TextField("", text: $financeVm.walletPhoneNumber)
                            .textFieldStyle(
                                CustomTextField(placeholder: NSLocalizedString("wallet_phone", comment: ""),
                                                textColor: genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText),
                                                placeholderColor: genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText),
                                                placeholderBgColor: genralVm.isDark ? Color(Colors().darkBodyBg):
                                                    Color(Colors().lightBodyBg),
                                                image: "charge_by_walletPhone",
                                                isEditing: !financeVm.walletPhoneNumber.isEmpty)
                            )
                            .onReceive(Just(financeVm.walletPhoneNumber)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    financeVm.walletPhoneNumber = filtered
                                }
                                if newValue.count > 11 {
                                    financeVm.walletPhoneNumber = String(newValue.prefix(11))
                                }
                            }
                        
                            .padding(.bottom,10)
                        
                        TextField("", text: $financeVm.walletPhoneMoneyCharged)
                            .textFieldStyle(
                                CustomTextField(placeholder: NSLocalizedString("money_charged", comment: ""),
                                                textColor: genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText),
                                                placeholderColor: genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText),
                                                placeholderBgColor: genralVm.isDark ? Color(Colors().darkBodyBg):
                                                    Color(Colors().lightBodyBg),
                                                image: "vec_money_1",
                                                isEditing: !financeVm.walletPhoneMoneyCharged.isEmpty)
                            )
                            .onReceive(Just(financeVm.walletPhoneMoneyCharged)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    financeVm.walletPhoneMoneyCharged = filtered
                                }
                                if newValue.count > 5 {
                                    financeVm.walletPhoneMoneyCharged = String(newValue.prefix(5))
                                }
                            }
                            .padding(.bottom,10)
                        
                        
                        HStack{
                            ButtonAction(text:NSLocalizedString("cancel", comment: ""), color: .red) {
                                financeVm.bottomSheetPositionWalletPhone = .hidden
                            }
                            
                            ButtonAction(text:NSLocalizedString("charge", comment: ""), color: .green) {
                                financeVm.payWallet(chargeValue: Double(financeVm.walletPhoneMoneyCharged) ?? 0.0, paymentPhoneNumber: financeVm.walletPhoneNumber, paymentTypeToken: genralVm.constants.PAYMENT_TYPE_PHONE_WALLET, phoneWallet: true)
                                financeVm.walletPhoneMoneyCharged.removeAll()
                                financeVm.walletPhoneNumber.removeAll()
                                
                            }
                        }
                        
                    }
                    .padding(.all, 15)
                    
                }
                
            )
            .enableBackgroundBlur(true)
            .enableContentDrag(true)
            .backgroundBlurMaterial(visualEffect)
            
            
            .bottomSheet(
                bottomSheetPosition: $financeVm.bottomSheetPositionWalletCode,
                switchablePositions: switchablePositions,
                headerContent: {},
                mainContent: {
                    VStack{
                        
                        HStack(spacing:10){
                            Image("charge_by_code")
                                .resizable()
                                .frame(width: 50,height: 50)
                            Text(NSLocalizedString("codeee", comment: ""))
                                .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 40)
                                        .weight(.bold)
                                )
                                .lineLimit(1)
                        }
                        .frame(alignment: .center)
                        .padding()
                        
                        TextField("", text: $financeVm.codeCharged)
                            .textFieldStyle(
                                CustomTextField(placeholder: NSLocalizedString("codeee", comment: ""),
                                                textColor: genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText),
                                                placeholderColor: genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText),
                                                placeholderBgColor: genralVm.isDark ? Color(Colors().darkBodyBg):
                                                    Color(Colors().lightBodyBg),
                                                image: "charge_by_code",
                                                isEditing: !financeVm.codeCharged.isEmpty)
                            )
                            .onChange(of: financeVm.codeCharged) { newValue in
                                guard !newValue.isEmpty else { return }
                                let sanitizedText = Helper.sanitizeInput(newValue)
                                if sanitizedText != newValue {
                                    financeVm.codeCharged = sanitizedText
                                }
                            }
                        
                        
                        HStack{
                            ButtonAction(text:NSLocalizedString("cancel", comment: ""), color: .red) {
                                financeVm.bottomSheetPositionWalletCode = .hidden
                            }
                            
                            ButtonAction(text:NSLocalizedString("charge", comment: ""), color: .green) {
                                financeVm.submitCode(code: financeVm.codeCharged)
                                financeVm.codeCharged.removeAll()
                                
                            }
                        }
                        
                    }
                    .padding(.all, 15)
                }
            )
            .enableBackgroundBlur(true)
            .enableContentDrag(true)
            .backgroundBlurMaterial(visualEffect)
            
            
            
            .bottomSheet(
                bottomSheetPosition: $financeVm.bottomSheetPositionWalletVisa,
                switchablePositions: switchablePositions,
                headerContent: {},
                mainContent: {
                    
                    VStack{
                        
                        HStack(spacing:10){
                            Image("charge_by_visa")
                                .resizable()
                                .frame(width: 50,height: 50)
                            Text(NSLocalizedString("visa", comment: ""))
                                .foregroundColor(genralVm.isDark ? Color(Colors().darkCardText): Color(Colors().lightCardText))
                                .font(
                                    Font.custom(Fonts().getFontBold(), size: 40)
                                        .weight(.bold)
                                )
                                .lineLimit(1)
                        }
                        .frame(alignment: .center)
                        .padding()
                        
                        TextField("", text: $financeVm.walletVisaMoneyCharged)
                            .textFieldStyle(
                                CustomTextField(placeholder: NSLocalizedString("money_charged", comment: ""),
                                                textColor: genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText),
                                                placeholderColor: genralVm.isDark ? Color(Colors().darkBodyText): Color(Colors().lightBodyText),
                                                placeholderBgColor: genralVm.isDark ? Color(Colors().darkBodyBg):
                                                    Color(Colors().lightBodyBg),
                                                image: "vec_money_1",
                                                isEditing: !financeVm.walletVisaMoneyCharged.isEmpty)
                            )
                        
                            .onReceive(Just(financeVm.walletVisaMoneyCharged)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    financeVm.walletVisaMoneyCharged = filtered
                                }
                                if newValue.count > 5 {
                                    financeVm.walletVisaMoneyCharged = String(newValue.prefix(5))
                                }
                            }
                        
                        
                        HStack{
                            ButtonAction(text:NSLocalizedString("cancel", comment: ""), color: .red) {
                                financeVm.bottomSheetPositionWalletVisa = .hidden
                            }
                            
                            ButtonAction(text:NSLocalizedString("ok", comment: ""), color: .green) {
                                financeVm.payWallet(chargeValue: Double(financeVm.walletVisaMoneyCharged) ?? 0.0, paymentPhoneNumber: "", paymentTypeToken: genralVm.constants.PAYMENT_TYPE_BANK, phoneWallet: false)
                                financeVm.walletVisaMoneyCharged.removeAll()
                                
                            }
                        }
                        
                    }
                    .padding(.all, 15)
                    
                }
                
            )
            .enableBackgroundBlur(true)
            .enableContentDrag(true)
            .backgroundBlurMaterial(visualEffect)
            
        }
        .padding(.bottom, keyboard.currentHeight) // Adjust the padding based on keyboard height
        .animation(.easeOut(duration: 0.16), value: keyboard.currentHeight)
        .edgesIgnoringSafeArea(.bottom)
        
        .toastView(toast: $toast)
        .toastView(toast: $financeVm.toast)
        
        .background(genralVm.isDark ? Color(Colors().darkBodyBg): Color(Colors().lightBodyBg))
        .ipad()
        
        .sheet(isPresented: $financeVm.openLinkPayMob, content: {
            WebView(url: URL(string: financeVm.urlPayMob ?? "")!, detector: detector)
                .onChange(of: detector.isScreenRecording) { isRecording in
                    if isRecording {
                        exit(0)
                    }
                }
            
                .edgesIgnoringSafeArea(.all)
            
        })
        
        
        .onAppear(perform: {
            if genralVm.isDark {
                visualEffect = VisualEffect.systemLight
            }
            financeVm.getFinanceData()
            userWalletTransactionVm.getUserWalletTransactionData()
        })
        .onDisappear(perform: {
            clearStatesWithAction(valueState: &genralVm.dissapearView)
        })
        
        .edgesIgnoringSafeArea(.all)
        .toastView(toast: $toast)
        
        .gesture(
            DragGesture()
                .onEnded { value in
                    // Check if the drag was mainly horizontal (left or right)
                    if abs(value.translation.width) > abs(value.translation.height) {
                        // Check if the drag was towards the left
                        if value.translation.width < 0 {
                            // Perform your action here
                            self.backFromWallet.toggle()
                        } else if value.translation.width > 0 {
                            self.backFromWallet.toggle()
                        }
                    }
                }
        )

        .gesture(
            DragGesture()
                .onEnded { value in
                    // Check if the drag was towards the left
                    if value.translation.width < 0 {
                        // Perform your action here
                        self.backFromWallet.toggle()
                    }else if value.translation.width > 0 {
                        self.backFromWallet.toggle()
                    }
                }
        )
        
        .overlay(
            financeVm.isLoading ?
            GeometryReader { geometry in
                ZStack {
                    LoadingView(placHolder: NSLocalizedString("loading", comment: ""))
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .transition(.scale)
                } } : nil
        )
        .refreshable {
            financeVm.getFinanceData()
            userWalletTransactionVm.getUserWalletTransactionData()
        }
       
        .fullScreenCover(isPresented: $backFromWallet, content: {
            StudentMainTabView()
        })
        .fullScreenCover(isPresented: $financeVm.showLogOut, content: {
            RegistrationView()
        })
        
    }
    
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy" // Customize date format as needed
        return formatter.string(from: date)
    }
    private func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        backFromWallet = false
    }
}
