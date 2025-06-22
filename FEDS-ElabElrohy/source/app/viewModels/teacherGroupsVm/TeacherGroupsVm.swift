//
//  TeacherGroupsVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 27/11/2023.
//

import Foundation

class TeacherGroupsVm : ObservableObject {
    @Published var educationGroupsData : [EducationalGroupsDatum] = []
    @Published var genralVm : GeneralVm = GeneralVm()

    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var paginated : Bool = false
    @Published var msg : String = ""
    
    var totalPages = 1
    var currentPage = 1
    var categoryToken = ""
    
    func getAllTeachersGroups(userServiceProviderToken : String,categoryToken:String){
       
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
                data.userServiceProviderToken = userServiceProviderToken
                data.priceListDataInclude = "true"
                data.educationalCategoryInfoDataInclude = "true"
                data.educationalCategoryToken = categoryToken
                data.educationalGroupStatisticsInfoDataInclude = "true"
         
                
                do {
                    try Api().getAllGroups(generalSearch:data ,onCompletion: { status, msg, data,pagination in
                 
                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.noData = false
                            self.totalPages = pagination.totalPages ?? 1
                            if !self.paginated {
                                self.educationGroupsData = []
                            }
                            self.educationGroupsData.append(contentsOf: data)
                         
                        } else if status == self.genralVm.constants.STATUS_INVALID_TOKEN {
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
