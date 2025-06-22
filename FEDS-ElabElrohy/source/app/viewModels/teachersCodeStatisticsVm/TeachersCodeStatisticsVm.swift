

import Foundation

class TeachersCodeStatisticsVm : ObservableObject {
    
    @Published var teacherCodeAvailablePricesStatistic : [TeacherCodeAvailablePricesStatistic] = []
    @Published var genralVm : GeneralVm = GeneralVm()

    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var showDetails : Bool = false
    @Published var msg : String = ""
    @Published var toast: Toast? = nil
    
    var userProviderToken = UserDefaultss().restoreString(key: "userProviderToken")
    var totalPages = 1
    var currentPage = 1
    var approvalToken : String = ""
    
    func getTeacherCodeAvailablePricesStatistic(userServiceProviderToken:String = ""){
       
        self.isLoading = true
        do {
            try Api().getTeacherCodeAvailablePricesStatistics(userAuthorizeToken: self.genralVm.authToken, userServiceProviderToken: userServiceProviderToken,onCompletion: { status, msg, data in
      
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    self.isLoading = false
                    self.noData = false
                    self.teacherCodeAvailablePricesStatistic = []
                    self.teacherCodeAvailablePricesStatistic.append(contentsOf: data)

                 
                } else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                            status == self.genralVm.constants.STATUS_VERSION{
                    self.isLoading = false
                    self.showDetails = false
                    self.showLogOut = true
                    self.msg = msg
                    Helper.removeUserDefaultsAndCashes()
                    UserDefaults.standard.set(msg, forKey: "logoutMsg")
                }else {
                    self.isLoading = false
                    self.showDetails = false
                    self.noData = true
                    self.msg = msg
                }
            })
        } catch {
            self.isLoading = false
            self.showDetails = false
            self.msg = error.localizedDescription
        }
    }
    
    
    func requestCode(userProviderToken : String , teacherCodePrice : Double ){
       isLoading = true
       
       do {
           try Api().buyTeacherCode(userAuthorizeToken: self.genralVm.authToken, userServiceProviderToken: userProviderToken, teacherCodePrice: teacherCodePrice) { status, msg in
               
               if status == self.genralVm.constants.STATUS_SUCCESS {
                   self.isLoading = false
                   self.msg = msg
                   self.toast = Helper.showToast(style: .success, message: msg)
                   self.getTeacherCodeAvailablePricesStatistic(userServiceProviderToken: self.userProviderToken)
                   
               } else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                            status == self.genralVm.constants.STATUS_VERSION{
                   self.isLoading = false
                   self.msg = msg
                   self.showLogOut = true
                   Helper.removeUserDefaultsAndCashes()
                   UserDefaults.standard.set(msg, forKey: "logoutMsg")

               }else {
                   self.isLoading = false
                   self.msg = msg
                   self.toast = Helper.showToast(style: .error, message: msg)
               }
           }
       } catch {
           self.isLoading = false
           self.msg = error.localizedDescription
           self.toast = Helper.showToast(style: .error, message: msg)
     
       }
   }
    
 

}
