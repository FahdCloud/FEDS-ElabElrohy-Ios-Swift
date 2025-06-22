//
//  EducationAttendnaceHistoryVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 24/10/2023.
//

import Foundation

class EducationAttendnaceHistoryVm : ObservableObject {
    @Published var genralVm : GeneralVm = GeneralVm()

    @Published var attendnaceHistoryData : [EducationalGroupAttendancesDatum] = []
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var msg : String = ""
    
    
    var currentPage = 0
    var totalPages = 0
  

    func getAttendanceHistory(searchType:String,month: String,year : String, day :String){
    
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
                data.userToken = self.genralVm.userToken
                data.educationalGroupScheduleTimeInfoDataInclude = "true"
                data.calendarSearchType = searchType
                data.calendarMonth = month
                data.calendarDay = day
                data.calendarYear = year
            
                
                do {
                    try Api().getAttendanceHistoryData(generalSearch:data ,onCompletion: { status, msg, data,pagination in
              
                        if status == self.genralVm.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.noData = false
                            self.totalPages = pagination.totalPages ?? 1
                            self.attendnaceHistoryData = []
                            self.attendnaceHistoryData.append(contentsOf: data)
                         
                        }   else if status == self.genralVm.constants.STATUS_INVALID_TOKEN {
                            self.isLoading = false
//                            self.noData = true
                            self.showLogOut = true
                            self.msg = msg
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
//
//  EducationGroupsTimeVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 05/09/2023.
//

import Foundation

class EducationAttendnaceHistoryVmm : ObservableObject {
    @Published var calendarManager = StudentHomeScheduleCalenderView()

    var lang = Locale.current.language.languageCode!.identifier
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    var userToken = UserDefaultss().restoreString(key: "userToken")
    
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
    var currentPage : Int = 1
    var tottalPages : Int = 1
    var constants = Constants()
    private let itemsFromEndThreshold = 15

   @Published var totalItems : Int?
   @Published var countItemInPage : Int?
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
    
    func getData(isRefresh : Bool = false ,year : String = ""  , month : String = "", day : String = "" ,educationCategoryToken : String = "",pages:Int = 1,calenderSearchType:String = "",dateTimeStartSearch:String = "",dateTimeEndSearch:String = "",educationalGroupToken:String = "") throws {
      
         self.isLoading = true
         do {
             let data = try JSONEncoder().encode(GeneralSearch())
             UserDefaults.standard.set(data, forKey: "apiData")
             do {
                 
                 let decoder = JSONDecoder()
                 let data = try decoder.decode(GeneralSearch.self, from: data)
                 data.userAuthorizeToken = self.authToken
                 data.paginationStatus = "true"
                 data.page = self.currentPage
                 data.pageSize = self.constants.PAGE_SIZE
                 data.activationTypeTokens = "AST-17400"
                 data.filterStatus = "true"
                 data.userStudentToken = self.userToken
                 data.educationalCategoryToken = self.token
                 data.calendarSearchType = calenderSearchType
                 data.calendarYear = self.year
                 data.calendarMonth = self.month
                 data.calendarDay = self.day
                 data.dateTimeStartSearch = dateTimeStartSearch
                 data.dateTimeEndSearch = dateTimeEndSearch
                 data.educationalGroupToken = educationalGroupToken
                
                 
                 do {
                     try Api().getEducationalGroupScheduleTimes(generalSearch: data) { (status ,msg,data,pagniation) in
              
                         if status == Constants().STATUS_SUCCESS {
                             
                             self.isLoading = false
                             self.noData = false
                             self.tottalPages = pagniation.totalPages ?? 0
                             self.countItemInPage = pagniation.countItemsInPage ?? 0
                             self.totalItems = pagniation.totalItems ?? 0
                             
                             if isRefresh {
                                 self.educationalGroupScheduleTimes = []
                             }
                             self.educationalGroupScheduleTimes = []
                             self.educationalGroupScheduleTimes.append(contentsOf: data)
                                                      
     
                         }    else if status == self.constants.STATUS_INVALID_TOKEN ||
                                        status == self.constants.STATUS_VERSION {
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

    
    func requestInitialSetOfItems() {
        currentPage = 0
        requestItems(page: currentPage)
    }
    
    // 2
    /// Used for infinite scrolling. Only requests more items if pagination criteria is met.
    func requestMoreItemsIfNeeded(index: Int) {
        guard let itemsLoadedCount = countItemInPage,
              let totalItemsAvailable = totalItems else {
            return
        }
        
        if thresholdMeet(itemsLoadedCount, index) &&
            moreItemsRemaining(itemsLoadedCount, totalItemsAvailable) {
            // Request next page
            currentPage += 1
            requestItems(page: currentPage)
        }
    }
    
    // 3
    private func requestItems(page: Int) {
        isLoading = true
        do {
            try  getData(year: "2023", month: "11", day: "11",pages : page)

        } catch {
            
        }
    }
    
    //4
    /// Determines whether we have meet the threshold for requesting more items.
    private func thresholdMeet(_ itemsLoadedCount: Int, _ index: Int) -> Bool {
        return (itemsLoadedCount - index) == itemsFromEndThreshold
    }
    
    //5
    /// Determines whether there is more data to load.
    private func moreItemsRemaining(_ itemsLoadedCount: Int, _ totalItemsAvailable: Int) -> Bool {
        return itemsLoadedCount < totalItemsAvailable
    }

}
