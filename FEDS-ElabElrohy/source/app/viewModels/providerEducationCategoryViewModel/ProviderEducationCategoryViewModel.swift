//
//  ProviderEducationCategoryViewModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 09/10/2023.
//

import Foundation

class ProviderEducationCategoryViewModel : ObservableObject {
    
    var lang = Locale.current.language.languageCode!.identifier
    var constants = Constants()
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    var userToken = UserDefaultss().restoreString(key: "userToken")
    
    @Published var users : [UsersDatum] = []
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var msg : String = ""
    
    
    
    func getEducationCategoriesProvider(educationCategoryToken : String){
        
        self.isLoading = true
        
        do {
            let data = try JSONEncoder().encode(GeneralSearch())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
                
                let decoder = JSONDecoder()
                let data = try decoder.decode(GeneralSearch.self, from: data)
                data.userAuthorizeToken = self.authToken
                data.activationTypeTokens = "AST-17400"
                data.userTypeToken = self.constants.USER_TYPE_TOKEN_PROVIDER
                data.userEducationalInterestToken = educationCategoryToken
                data.filterStatus = "true"
                data.paginationStatus = "false"
                
           
                do {
                    try Api().getUserOfEducationCategory(generalSearch:data ,onCompletion: { status, msg, data,pagination in
             
                        if status == self.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.noData = false
                            self.users = []
                            self.users.append(contentsOf: data)
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
                
            }
            
            
        } catch {
            
        }
        
      
        
    }

    
}
