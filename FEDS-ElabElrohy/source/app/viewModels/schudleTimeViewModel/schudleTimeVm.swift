//
//  schudleTimeVm.swift
//  FEDS-Center-Dev
//
//  Created by Omar pakr on 03/01/2024.
//

import Foundation


class SchudleTimeVm : ObservableObject {
    @Published var calendarManager = StudentHomeScheduleCalenderView()
    @Published var genralVm : GeneralVm = GeneralVm()

    
    
    @Published var educationalGroupScheduleTimes : [UserEducationalGroupScheduleTimesDatum] = []

    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var msg : String = ""
    @Published var token : String = ""
    @Published var day : String = ""
    @Published var month : String = ""
    @Published var year : String = ""
    @Published var groupToken : String = ""
    let calendarr = Calendar.current
    @Published var selectedDate: Date? = nil
    
    init(){
        getDate(date: Date())
        do {
            try getData(year: year, month: month, day: day,calenderSearchType: Constants().CALENDER_SEARCH_TYPE_TOKEN_SIMPOL_DAY)
        } catch {
    }
}
    
    func getDate(date : Date){
        
          let components = calendarr.dateComponents([.day,.month,.year], from: date)
          if let day = components.day, let month = components.month, let year = components.year {
              let dayString = String(day)
              let monthString = String(month)
              let yearString = String(year)
              
              self.year = yearString
              self.day = dayString
              self.month = monthString
          
          }
    }
    
    func getData(year : String , month : String , day : String  ,educationCategoryToken : String = "",calenderSearchType : String = "",groupToken : String = "",userProviderToken : String = "") throws {
      
   
         self.isLoading = true
         do {
             let data = try JSONEncoder().encode(GeneralSearch())
             UserDefaults.standard.set(data, forKey: "apiData")
             do {
                 
                 let decoder = JSONDecoder()
                 let data = try decoder.decode(GeneralSearch.self, from: data)
                 data.userAuthorizeToken = self.genralVm.authToken
                 data.paginationStatus = "false"
                 data.page = 1
                 data.pageSize = Constants().PAGE_SIZE
                 data.activationTypeTokens = "AST-17400"
                 data.filterStatus = "true"
                 data.userStudentToken = self.genralVm.userToken
                 data.calendarSearchType = calenderSearchType
                 data.calendarYear = year
                 data.calendarMonth = month
                 data.educationalGroupToken = groupToken
                 data.calendarDay = day
                 
                
                 do {
                     try Api().getEducationalGroupScheduleTimes(generalSearch: data) { (status ,msg,data,pagniation) in
                  
                         if status == Constants().STATUS_SUCCESS {
                             self.isLoading = false
                             self.noData = false
                             self.educationalGroupScheduleTimes = []
                             self.educationalGroupScheduleTimes.append(contentsOf: data)
     
                         }    else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                                        status == self.genralVm.constants.STATUS_VERSION{
                             self.isLoading = false
                             self.showLogOut = true
                             Helper.removeUserDefaultsAndCashes()
                             UserDefaults.standard.set(msg, forKey: "logoutMsg")
                             self.msg = msg
                         }
                         else  {
                             self.isLoading = false
                             self.noData = true
                             self.msg = msg
                         }
                     }
                 }catch {
                     self.isLoading = false
                     self.noData = true
                     self.msg = NSLocalizedString("message_error_in_fetching_data", comment: "")
                 }
                 
             }catch {

                 self.isLoading = false
                 self.noData = true
                 self.msg = NSLocalizedString("message_error_in_fetching_data", comment: "")

             }
             
         }catch {

             self.isLoading = false
             self.noData = true
             self.msg = NSLocalizedString("message_error_in_fetching_data", comment: "")

         }
         
     }

}
