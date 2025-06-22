//
//  EducationCategoryViewModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 05/10/2023.
//

import Foundation


class EducationCategoryViewModel : ObservableObject {
    @Published var genralVm : GeneralVm = GeneralVm()
    
    @Published var educationCategory : [TreesDatum] = []
    @Published var educationCategoryData : [EducationalCategoriesDatum] = []
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var msg : String = ""
    @Published var prevToken : String = ""
    
    
    
    func getEducationCategory(){
        
        self.isLoading = true
        
        do {
            let data = try JSONEncoder().encode(GeneralSearch())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
                
                let decoder = JSONDecoder()
                let data = try decoder.decode(GeneralSearch.self, from: data)
                data.userAuthorizeToken = self.genralVm.authToken
                data.activationTypeTokens = "AST-17400"
                data.filterStatus = "true"
                
                
                do {
                    try Api().getEducationalCategory(generalSearch:data ,onCompletion: { status, msg, data in
                        
                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.noData = false
                            self.educationCategory = []
                            self.educationCategory.append(contentsOf: data)
                        }   else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                        status == self.genralVm.constants.STATUS_VERSION{
                            self.isLoading = false
                            self.showLogOut = true
                            self.msg = msg
                            UserDefaults.standard.set(msg, forKey: "logoutMsg")
                            Helper.removeUserDefaultsAndCashes()
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
                
            }
            
            
        } catch {
            
        }
        
        
        
    }
    
    func getEducationCategoriesData(getParentEducationCategoryOnly : String = "true" ,prevEducationCategoryToken : String,educationCategoryToken : String = "",getOnlyChildEducationalCategories : String = "false"){
        
        self.isLoading = true
        
        do {
            let data = try JSONEncoder().encode(GeneralSearch())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
                
                let decoder = JSONDecoder()
                let data = try decoder.decode(GeneralSearch.self, from: data)
                data.userAuthorizeToken = self.genralVm.authToken
                data.activationTypeTokens = "AST-17400"
                data.filterStatus = "true"
                data.getOnlyParentEducationalCategories = getParentEducationCategoryOnly
                data.parentEducationalCategoryToken = educationCategoryToken
                data.getOnlyChildEducationalCategories = getOnlyChildEducationalCategories
                
                do {
                    try Api().getEducationalCategory(generalSearch:data ,onCompletion: { status, msg, data , pagination ,prevToken in
                        
                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.noData = false
                            self.prevToken = prevToken
                            self.educationCategoryData = []
                            
                            self.educationCategoryData.append(contentsOf: data)
                        }   else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                        status == self.genralVm.constants.STATUS_VERSION{
                            self.isLoading = false
                            self.showLogOut = true
                            self.msg = msg
                            UserDefaults.standard.set(msg, forKey: "logoutMsg")
                            Helper.removeUserDefaultsAndCashes()
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
                
            }
            
            
        } catch {
            
        }
        
        
        
    }
    
    
}
