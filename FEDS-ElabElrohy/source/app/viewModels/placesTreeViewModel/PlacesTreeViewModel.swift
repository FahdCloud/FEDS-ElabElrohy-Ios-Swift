//
//  PlacesTreeModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 10/10/2023.
//

import Foundation


class PlaceVm : ObservableObject {
    
    var lang = Locale.current.language.languageCode!.identifier
    var constants = Constants()
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    var userToken = UserDefaultss().restoreString(key: "userToken")
    
    @Published var places : [TreesData] = []
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var msg : String = ""
    
    
    
    func getPlaces(){
        
        self.isLoading = true
        
        do {
            try Api().getPlaces(authToken:self.authToken ,onCompletion: { status, msg, data in
     
                if status == self.constants.STATUS_SUCCESS {
                    self.places = []
                    self.isLoading = false
                    self.noData = false
                    self.places.append(contentsOf: data)
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
      
        
    }

    
}
