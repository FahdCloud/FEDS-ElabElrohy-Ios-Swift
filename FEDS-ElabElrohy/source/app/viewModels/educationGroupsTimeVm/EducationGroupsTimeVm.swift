//
//  EducationGroupsTimeVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 05/09/2023.
//

import Foundation


class EducationGroupTimeVm : ObservableObject {
    @Published var calendarManager = StudentHomeScheduleCalenderView()
    @Published var genralVm : GeneralVm = GeneralVm()

   
    @Published var educationalGroupScheduleTimes : [UserEducationalGroupScheduleTimesDatum] = []
    @Published var educationCategoryInfoData : [EducationalCategoryInfoData] = []
    @Published var educationalGroupInfoData : [EducationalGroupInfoData] = []
    @Published var educationSchulde : [EducationCategorySchudel] = []
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var msg : String = ""
    @Published var token : String = ""
    @Published var onlyOneCategory : Bool = false
    @Published var day : String = ""
    @Published var month : String = ""
    @Published var year : String = ""
    @Published var calenderSearchType : String = ""
    @Published var groupToken : String = ""
    let calendarr = Calendar.current
    @Published var selectedDate: Date? = nil
    
    
    init(){
        getDate(date: Date())
        do {
         try getData(year: year, month: month, day: day)
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
    
    func getData(year : String , month : String , day : String  ,educationCategoryToken : String = "",calenderSearchType : String = "",groupToken : String = "") throws {
      
   
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
                 data.pageSize = "150"
                 data.activationTypeTokens = "AST-17400"
                 data.filterStatus = "true"
                 data.userStudentToken = self.genralVm.userToken
                 data.educationalCategoryToken = self.token
                 data.calendarSearchType = "CST-1"
                 data.calendarYear = year
                 data.calendarMonth = month
//                 data.educationalGroupToken = groupToken
                 data.calendarDay = day
                 
                
                 do {
                     try Api().getEducationalGroupScheduleTimes(generalSearch: data) { (status ,msg,data,pagniation) in
                      
                         if status == Constants().STATUS_SUCCESS {
                             self.isLoading = false
                             self.noData = false
                             self.educationalGroupScheduleTimes = []
                             self.educationalGroupScheduleTimes.append(contentsOf: data)
     
                         }    else if status == Constants().STATUS_INVALID_TOKEN ||
                                        status == Constants().STATUS_VERSION{
                             self.isLoading = false
                             self.showLogOut = true
                             self.msg = msg
                             Helper.removeUserDefaultsAndCashes()
                             UserDefaults.standard.set(msg, forKey: "logoutMsg")
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
