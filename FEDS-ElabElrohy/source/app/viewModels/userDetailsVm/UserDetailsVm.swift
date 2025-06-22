//
//  TopViewCategoryVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 22/11/2023.
//

import Foundation


class TopViewCategoryVm : ObservableObject {
    
    var lang = Locale.current.language.languageCode!.identifier
    var constants = Constants()
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    var userToken = UserDefaultss().restoreString(key: "userToken")
    
    @Published var user : UserDetails = UserDetails()
    @Published var userEducationalCategoryInfoInterest : [UserEducationalCategoryInfoInterest] = [UserEducationalCategoryInfoInterest]()
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var msg : String = ""
 
    func getUserDetails(userToken : String){
        self.isLoading = true
        
        do {
            try Api().getUserDetails(userAuthorizeToken: self.authToken, token: userToken,onCompletion: { status, msg, data in
          
                if status == self.constants.STATUS_SUCCESS {
                    self.isLoading = false
                    self.noData = false
                    self.userEducationalCategoryInfoInterest = []
                    self.userEducationalCategoryInfoInterest.append(contentsOf: data.userEducationalCategoryInfoInterests!)
                }   else if status == self.constants.STATUS_INVALID_TOKEN {
                    self.isLoading = false
                    self.showLogOut = true
                    self.msg = msg
                }else {
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
    
}
