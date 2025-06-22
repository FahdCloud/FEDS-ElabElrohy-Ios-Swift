//
//  UserWalletTransactionViewModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 19/10/2023.
//

import Foundation

class UserWalletTransctionViewModel : ObservableObject {
    @Published var genralVm : GeneralVm = GeneralVm()
    @Published var userWalletTransactionData : [UserWalletTransactionsDatum] = []
    
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var msg : String = ""
    
    
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    var userToken = UserDefaultss().restoreString(key: "userToken")
  
    
    func getUserWalletTransactionData(){
        self.isLoading = true
    
        do {
            let data = try JSONEncoder().encode(GeneralSearch())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(GeneralSearch.self, from: data)
                data.userAuthorizeToken = self.authToken
                data.paginationStatus = "false"
                data.activationTypeTokens = "AST-17400"
                data.filterStatus = "true"
                data.userToken = self.userToken
                        
                        do {
                            try Api().getUserWalletTransactionData(generalSearch: data ,onCompletion: { status, msg, data in
                      
                                if status == self.genralVm.constants.STATUS_SUCCESS {
                                    self.isLoading = false
                                    self.noData = false
                                    self.userWalletTransactionData.append(contentsOf: data)
                                 
                                } else if status == self.genralVm.constants.STATUS_INVALID_TOKEN {
                                    self.isLoading = false
                                    self.showLogOut = true
                                    self.msg = msg
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
            } catch {
                self.isLoading = false
                self.msg = error.localizedDescription
            }
            
        } catch {
            self.isLoading = false
            self.msg = error.localizedDescription
        }
    }
}
