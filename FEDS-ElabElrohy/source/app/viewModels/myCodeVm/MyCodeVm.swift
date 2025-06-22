//
//  MyCodeModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 26/11/2023.
//

import Foundation

class MyCodeVm : ObservableObject {
    
    var lang = Locale.current.language.languageCode!.identifier
    var constants = Constants()
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    var userToken = UserDefaultss().restoreString(key: "userToken")
    
    @Published var teacherCode : [TeacherCodesDatum] = []
    @Published var teacherCodeStatistics : TeacherCodeStatistics = TeacherCodeStatistics()
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var logOut : Bool = false
    @Published var msg : String = ""
    var currentPage : Int = 1
    var totalPages : Int = 1
    
    
    
    
    func getTeacherCode(){
        
        self.isLoading = true
        
        do {
            let data = try JSONEncoder().encode(GeneralSearch())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
                
                let decoder = JSONDecoder()
                let data = try decoder.decode(GeneralSearch.self, from: data)
                data.userAuthorizeToken = self.authToken
                data.activationTypeTokens = "AST-17400"
                data.pageSize = self.constants.PAGE_SIZE
                data.page = self.currentPage
                data.filterStatus = "true"
                data.paginationStatus = "true"
                data.userStudentToken = self.userToken
                data.userServiceProviderInfoDataInclude = "true"
           
                do {
                    try Api().myTeacherCodes(generalSearch:data ,onCompletion: { status, msg, data,statistics,pagination in
                
                        if status == self.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.noData = false
                            self.teacherCodeStatistics = statistics
                            self.totalPages = pagination.totalPages ?? 1
                            self.teacherCode = []
                            self.teacherCode.append(contentsOf: data)
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
