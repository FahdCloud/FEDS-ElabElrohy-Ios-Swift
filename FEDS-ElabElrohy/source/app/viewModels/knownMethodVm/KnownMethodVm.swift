//
//  KnownMethodVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 10/10/2023.
//

import Foundation

class KnowMethodVm : ObservableObject {
    @Published var knowMethod : [KnownMethodsDatum] = []
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var msg : String = ""
    
    var lang = Locale.current.language.languageCode!.identifier
    var constants = Constants()
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    var userToken = UserDefaultss().restoreString(key: "userToken")
    
  
    
    func getKnownMethod (authToken : String ) {
        do {
            try Api().getKnowMethod(authToken: authToken) { status, msg, data in
     
                if status == self.constants.STATUS_SUCCESS {
                    self.knowMethod = []
                    self.isLoading = false
                    self.noData = false
                    self.knowMethod.append(contentsOf: data)
                } else {
                    self.isLoading = false
                    self.noData = true
                    self.msg = msg
                }
            }
        } catch {
            self.isLoading = false
            self.msg = error.localizedDescription
        }
    }
    
    
}
