//
//  EducationGroupTimeMediaVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 30/10/2023.
//

import Foundation
import FSCalendar

class EducationGroupTimeMediaVm : ObservableObject {
    @Published var genralVm : GeneralVm = GeneralVm()
    
    @Published var educationalGroupScheduleTimesMedia : [SystemMediaDatum] = []
    
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var msg : String = ""
    @Published var year : String = ""
    @Published var month : String = ""
    @Published var day : String = ""
    
    func getEducationGroupTimesMedia(groupTimeMediaToken :String,groupMediaToken:String = "")  {
        
        self.isLoading = true
        do {
            let data = try JSONEncoder().encode(GeneralSearch())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
                
                let decoder = JSONDecoder()
                let data = try decoder.decode(GeneralSearch.self, from: data)
                data.userAuthorizeToken = self.genralVm.authToken
                data.paginationStatus = "true"
                data.page = 1
                data.pageSize = Constants().PAGE_SIZE
                data.activationTypeTokens = "AST-17400"
                data.filterStatus = "true"
                data.educationalGroupScheduleTimeToken = groupTimeMediaToken
                data.educationalGroupToken = groupMediaToken
                
                
                do {
                    try Api().getEducationalGroupScheduleTimesMedia(generalSearch: data) { (status ,msg,data,pagniation) in
                        
                        if status == Constants().STATUS_SUCCESS {
                            
                            self.isLoading = false
                            self.noData = false
                            self.educationalGroupScheduleTimesMedia = []
                            self.educationalGroupScheduleTimesMedia.append(contentsOf: data)
                            
                        }    else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                        status == self.genralVm.constants.STATUS_VERSION {
                            self.isLoading = false
                            self.showLogOut = true
                            self.msg = msg
                            Helper.removeUserDefaultsAndCashes()
                            UserDefaults.standard.set(msg, forKey: "logoutMsg")
                        }
                        else  {
                            self.isLoading = false
                            self.noData = true
                            self.msg = msg
                        }
                    }
                }catch {
                    self.isLoading = false
                    self.noData = true
                    self.msg = NSLocalizedString("message_error_in_fetching_data", comment: "")
                }
                
            }catch {
                
                self.isLoading = false
                self.noData = true
                self.msg = NSLocalizedString("message_error_in_fetching_data", comment: "")
                
            }
            
        }catch {
            
            self.isLoading = false
            self.noData = true
            self.msg = NSLocalizedString("message_error_in_fetching_data", comment: "")
            
        }
        
    }
    
}
