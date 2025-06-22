//
//  FamilyVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 05/11/2023.
//

import Foundation
class ChildrenVm : ObservableObject {
    
    @Published var childrenData = [MyChild]()

  
     func getdata(){
        if let data = UserDefaults.standard.data(forKey: "childrenData") {
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode([MyChild].self, from: data)
                    
                self.childrenData.append(contentsOf:user)
               

            }catch {
              Helper.traceCrach(error: error, userToken: "")
            }
        }
    }
}
