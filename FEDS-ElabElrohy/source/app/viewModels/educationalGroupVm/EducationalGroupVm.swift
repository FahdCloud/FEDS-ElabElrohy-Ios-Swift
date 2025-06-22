//
//  EducationalGroupVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 23/10/2023.
//

import Foundation



class EducationalGroupsVm : ObservableObject {
    
    @Published var educationalGroupData : [EducationalGroupStudentsDatum] = []
    @Published var allEducationalGroupData : [EducationalGroupsData] = []
    @Published var genralVm : GeneralVm = GeneralVm()

    
    @Published var isLoading : Bool = false
    @Published var showLogOut : Bool = false
    @Published var paginated : Bool = false
    @Published var noData : Bool = false
    @Published var msg : String = ""
    
    
    var lang = Locale.current.language.languageCode!.identifier
    var totalPages = 1
    var currentPage = 1
    var approvalToken : String = ""
    var categoryToken : String = ""
    
    func getEducationGroups(finishedToken: String, userServiceProviderToken:String = "",refresh:Bool = false){
   
        self.isLoading = true
        
        do {
            let data = try JSONEncoder().encode(GeneralSearch())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
                
                let decoder = JSONDecoder()
                let data = try decoder.decode(GeneralSearch.self, from: data)
                data.userAuthorizeToken = self.genralVm.authToken
                data.paginationStatus = "true"
                data.pageSize = self.genralVm.constants.PAGE_SIZE
                data.page = currentPage
                data.activationTypeTokens = "AST-17400"
                data.filterStatus = "true"
                data.userStudentToken = self.genralVm.userToken
                data.educationalCategoryInfoDataInclude = "true"
                data.educationalGroupStatisticsInfoDataInclude = "true"
                data.educationalGroupInfoDataInclude = "true"
                data.userServiceProviderInfoDataInclude = "true"
                data.educationalGroupFinishTypeToken = finishedToken
                data.educationalCategoryToken = self.categoryToken
                data.userServiceProviderToken = userServiceProviderToken
            
                
                do {
                    try Api().getStudentEduactionGroups(generalSearch:data ,onCompletion: { status, msg, data,pagination in
            
                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.noData = false
                            self.totalPages = pagination.totalPages ?? 1
                            if !self.paginated {
                                self.educationalGroupData = []
                            }
                            self.educationalGroupData.append(contentsOf: data)
                         
                        }   else if status == self.genralVm.constants.STATUS_INVALID_TOKEN
                                        || status == self.genralVm.constants.STATUS_VERSION {
                            self.isLoading = false
                            self.msg = msg
                            self.showLogOut = true
                            Helper.removeUserDefaultsAndCashes()
                            UserDefaults.standard.set(msg, forKey: "logoutMsg")
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

    func getGroups(finishedToken: String,
                   userServiceProviderToken:String = "",
                    educationalCategoryToken : String = "",
                   refresh:Bool = false){
   
        self.isLoading = true
        
        do {
            let data = try JSONEncoder().encode(GeneralSearch())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
                let decoder = JSONDecoder()
                let data = try decoder.decode(GeneralSearch.self, from: data)
                data.userAuthorizeToken = self.genralVm.authToken
                data.paginationStatus = "false"
                data.pageSize = self.genralVm.constants.PAGE_SIZE
                data.page = currentPage
                data.activationTypeTokens = "AST-17400"
                data.filterStatus = "true"
                data.educationalCategoryInfoDataInclude = "true"
                data.educationalGroupStatisticsInfoDataInclude = "true"
                data.educationalGroupInfoDataInclude = "true"
                data.userServiceProviderInfoDataInclude = "true"
                data.userServiceProviderToken = userServiceProviderToken
                data.educationalCategoryToken = educationalCategoryToken
                data.educationalGroupFinishTypeToken = finishedToken
                do {
                    try Api().getEduactionGroups(generalSearch:data ,onCompletion: { status, msg, data,pagination in
                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.noData = false
                            self.totalPages = pagination.totalPages ?? 1
                            if refresh {
                                self.educationalGroupData = []
                            }
                            self.allEducationalGroupData.append(contentsOf: data)
                         
                        }   else if status == self.genralVm.constants.STATUS_INVALID_TOKEN
                                        || status == self.genralVm.constants.STATUS_VERSION {
                            self.isLoading = false
                            self.msg = msg
                            self.showLogOut = true
                            Helper.removeUserDefaultsAndCashes()
                            UserDefaults.standard.set(msg, forKey: "logoutMsg")
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
