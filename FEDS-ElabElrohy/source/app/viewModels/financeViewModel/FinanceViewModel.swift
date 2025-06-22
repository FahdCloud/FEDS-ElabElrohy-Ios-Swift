//
//  FinanceViewModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 17/10/2023.
//

import Foundation

import BottomSheetSwiftUI


class FinaceViewModel : ObservableObject {
    @Published var genralVm : GeneralVm = GeneralVm()
    @Published var userWalletTransactionVm : UserWalletTransctionViewModel = UserWalletTransctionViewModel()
    @Published var userFinanceStatisticData : UserFinanceStatisticData = UserFinanceStatisticData()
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var openLinkPayMob : Bool = false
    @Published var showLogOut : Bool = false
    @Published var msg : String = ""
    @Published var urlPayMob : String = ""
    @Published  var toast: Toast? = nil
    
    
    
    @Published  var bottomSheetPositionWalletCode: BottomSheetPosition = .hidden
    @Published  var bottomSheetPositionWalletPhone: BottomSheetPosition = .hidden
    @Published  var bottomSheetPositionWalletVisa: BottomSheetPosition = .hidden
    
    
    @Published  var codeCharged = ""
    @Published  var walletPhoneMoneyCharged = ""
    @Published  var walletPhoneNumber = ""
    @Published  var walletVisaMoneyCharged = ""
    
    func getFinanceData(){
        
        self.isLoading = true
        
        do {
            try Api().getUserFinanceData(authToken : self.genralVm.authToken,userToken:self.genralVm.userToken ,onCompletion: { status, msg, data in
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    self.isLoading = false
                    self.noData = false
                    self.userFinanceStatisticData = data
                    
                }   else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                status == self.genralVm.constants.STATUS_VERSION {
                    self.isLoading = false
                    self.showLogOut = true
                    self.msg = msg
                    Helper.removeUserDefaultsAndCashes()
                    UserDefaults.standard.set(msg, forKey: "logoutMsg")
                    
                } else {
                    self.isLoading = false
                    self.noData = true
                    self.msg = msg
                }
            })
        } catch {
            self.isLoading = false
            self.msg = error.localizedDescription
            
        }
        
    }
    
    func payWallet(chargeValue : Double , paymentPhoneNumber : String ,paymentTypeToken :String,phoneWallet : Bool){
        
        self.isLoading = true
        do {
            try Api().payWallet(authToken: self.genralVm.authToken, chargeValue: chargeValue, paymentPhoneNumber: phoneWallet ? paymentPhoneNumber : "", paymentTypeToken: phoneWallet ? genralVm.constants.PAYMENT_TYPE_PHONE_WALLET : genralVm.constants.PAYMENT_TYPE_BANK, onCompletion: {url, status, msg in
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    self.isLoading = false
                    self.noData = false
                    self.openLinkPayMob = true
                    self.urlPayMob = url
                    self.walletPhoneNumber.removeAll()
                    self.walletVisaMoneyCharged.removeAll()
                    self.walletPhoneMoneyCharged.removeAll()
                    self.bottomSheetPositionWalletVisa = .hidden
                    self.bottomSheetPositionWalletPhone = .hidden
                    self.getFinanceData()
                    
                    self.userWalletTransactionVm.userWalletTransactionData.removeAll()
                    self.userWalletTransactionVm.getUserWalletTransactionData()
                    
                }   else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                status == self.genralVm.constants.STATUS_VERSION {
                    self.isLoading = false
                    self.showLogOut = true
                    self.msg = msg
                    Helper.removeUserDefaultsAndCashes()
                    UserDefaults.standard.set(msg, forKey: "logoutMsg")
                }else {
                    self.isLoading = false
                    self.noData = true
                    self.msg = msg
                    self.bottomSheetPositionWalletVisa = .hidden
                    self.bottomSheetPositionWalletPhone = .hidden
                    self.toast = Helper.showToast(style: .error, message:msg)
                }
            })
        } catch {
            
            self.bottomSheetPositionWalletVisa = .hidden
            self.bottomSheetPositionWalletPhone = .hidden
            self.isLoading = false
            self.msg = error.localizedDescription
            self.toast = Helper.showToast(style: .error, message: NSLocalizedString("message_error_in_fetching_data", comment: ""))
        }
    }
    
    func submitCode(code:String){
        isLoading = true
        do {
            try Api().payCode(authToken: self.genralVm.authToken, code: Helper.arToEn(number: code)){ status,msg in
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    self.isLoading = false
                    self.toast = Helper.showToast(style: .success, message:msg)
                    self.codeCharged.removeAll()
                    self.bottomSheetPositionWalletCode = .hidden
                    self.getFinanceData()
                    
                    self.userWalletTransactionVm.userWalletTransactionData.removeAll()
                    self.userWalletTransactionVm.getUserWalletTransactionData()
                    
                }   else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                status == self.genralVm.constants.STATUS_VERSION {
                    self.isLoading = false
                    self.showLogOut = true
                    self.msg = msg
                    Helper.removeUserDefaultsAndCashes()
                    UserDefaults.standard.set(msg, forKey: "logoutMsg")
                    
                } else {
                    self.isLoading = false
                    self.bottomSheetPositionWalletCode = .hidden
                    self.toast = Helper.showToast(style: .error, message:msg)
                }
            }
        } catch {
            self.isLoading = false
            self.bottomSheetPositionWalletCode = .hidden
            self.toast = Helper.showToast(style: .error, message: NSLocalizedString("message_error_in_fetching_data", comment: ""))
        }
    }
}
