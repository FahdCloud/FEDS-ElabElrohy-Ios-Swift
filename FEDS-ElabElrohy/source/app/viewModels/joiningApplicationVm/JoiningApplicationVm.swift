//
//  JoiningApplicationVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 12/10/2023.
//

import Foundation

class JoiningApplicationVm : ObservableObject {
    @Published var joiningApplicationsData : [EducationalJoiningApplicationsDatum] = []
    @Published var joinigAppStatistics : EducationalJoiningApplicationsStatistics = EducationalJoiningApplicationsStatistics()
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var msg : String = ""
    
    
    var lang = Locale.current.language.languageCode!.identifier
    var constants = Constants()
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    var userToken = UserDefaultss().restoreString(key: "userToken")
    var totalPages = 1
    var currentPage = 1
    var approvalToken : String = ""
    var rejectedCount : Int = 0
    var underReviewCount : Int = 0
    var approvedCount : Int = 0
    var totalCount : Int = 0
    
    func getEducationJoiningApplication(refresh:Bool = false){
    
        self.isLoading = true
        
        do {
            let data = try JSONEncoder().encode(GeneralSearch())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
                
                let decoder = JSONDecoder()
                let data = try decoder.decode(GeneralSearch.self, from: data)
                data.userAuthorizeToken = self.authToken
                data.paginationStatus = "true"
                data.pageSize = self.constants.PAGE_SIZE
                data.page = currentPage
                data.activationTypeTokens = "AST-17400"
                data.filterStatus = "true"
                data.userStudentToken = self.userToken
                data.approvalTypeToken = self.approvalToken
            
                
                do {
                    try Api().getEducationJoiningApplication(generalSearch:data ,onCompletion: { status, msg, data,pagination , statistics in
              
                        if status == self.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.noData = false
                            self.underReviewCount = statistics.totalUnderReviewCount ?? 0
                            self.rejectedCount = statistics.totalRejectedCount ?? 0
                            self.approvedCount = statistics.totalAcceptedCount ?? 0
                            self.totalCount = statistics.totalCount ?? 0
                            self.totalPages = pagination.totalPages ?? 1
                            if refresh {
                                self.joiningApplicationsData = []
                            }
                            self.joiningApplicationsData = []
                            self.joiningApplicationsData.append(contentsOf: data)
                         
                        }  else if status == self.constants.STATUS_INVALID_TOKEN {
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
