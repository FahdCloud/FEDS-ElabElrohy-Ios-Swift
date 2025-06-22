//
//  NewsVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 12/11/2023.
//

import Foundation
import BottomSheetSwiftUI

class NewsVm : ObservableObject {
    @Published var newsData : [NewsArticlesDatum] = []
    @Published var genralVm : GeneralVm = GeneralVm()

    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var paginated : Bool = false
    @Published var msg : String = ""
    
    var totalPages = 1
    var currentPage = 1
    
    func getNews(isSlider : Bool = true){
       
        self.isLoading = true
        
        do {
            let data = try JSONEncoder().encode(GeneralSearch())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
                
                let decoder = JSONDecoder()
                let data = try decoder.decode(GeneralSearch.self, from: data)
                data.userAuthorizeToken = self.genralVm.authToken
                data.paginationStatus = "true"
                data.pageSize = self.genralVm.constants.PAGE_SIZE == "" ? "50" : self.genralVm.constants.PAGE_SIZE
                data.page = currentPage
                data.activationTypeTokens = "AST-17400"
                data.filterStatus = "true"

          
                do {
                    try Api().getNews(generalSearch:data ,onCompletion: { status, msg, data,pagination in

                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.noData = false
                            self.showLogOut = false
                            self.totalPages = pagination.totalPages ?? 1
                            if !self.paginated {
                                self.newsData = []
                            }
                            if isSlider {
                                self.newsData.append(contentsOf: data.prefix(10))
                            } else {
                                self.newsData.append(contentsOf: data)
                            }
                            
                         
                        } else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                    status == self.genralVm.constants.STATUS_VERSION {
                            self.isLoading = false
                            self.msg = msg
                            self.showLogOut = true
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
                    self.noData = true
                    self.isLoading = false
                    self.msg = error.localizedDescription
                }
                
            } catch {
                self.noData = true
                self.isLoading = false
                self.msg = error.localizedDescription
            }
            
            
        } catch {
            self.noData = true
            self.isLoading = false
            self.msg = error.localizedDescription
        }
    }

}
