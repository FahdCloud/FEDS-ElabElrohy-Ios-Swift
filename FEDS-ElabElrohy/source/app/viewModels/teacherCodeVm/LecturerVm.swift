//
//  TeacherCodeVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 26/11/2023.
//

import Foundation


class LecturerVm : ObservableObject {
    @Published var genralVm : GeneralVm = GeneralVm()

   
    var categoryToken = UserDefaultss().restoreString(key: "categoryToken")
    
    @Published var users : [UsersDatum] = []
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var msg : String = ""
    var currentPage : Int = 1
    var totalPages : Int = 1
    
    
    func getUsers(refresh:Bool = false, userTypeToken : String, educationalCategoryToken : String){
        
        self.isLoading = true
       
                do {
                    try Api().getUsers(authToken: genralVm.authToken, activationTypeTokens: genralVm.constants.ACTIVATION_TYPE_TOKEN, userTypeToken: userTypeToken, filterStatus: genralVm.constants.FILTER_STATUS_ON, paginationStatus: genralVm.constants.PAGINATION_STATUS_OFF, userEducationlInterestToken: self.categoryToken ,onCompletion: { status, msg, data,pagination in
                        
                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.noData = false
                            self.showLogOut = false
                            self.totalPages = pagination.totalPages ?? 1
                            if refresh {
                                self.users = []
                            }
                            self.users.append(contentsOf: data)
                        }else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                    status == self.genralVm.constants.STATUS_VERSION {
                            self.isLoading = false
                            self.showLogOut = true
                            self.msg = msg
                            Helper.removeUserDefaultsAndCashes()
                            UserDefaults.standard.set(msg, forKey: "logoutMsg")
                        } else {
                            self.showLogOut = false
                            self.isLoading = false
                            self.noData = true
                            self.msg = msg
                        }
                    })
                } catch {
                    self.showLogOut = false
                    self.isLoading = false
                    self.msg = error.localizedDescription
                }
                
        
    }
}
