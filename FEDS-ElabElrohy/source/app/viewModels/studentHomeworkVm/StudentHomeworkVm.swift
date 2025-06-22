//
//  StudentHomeworkVm.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Mrwan on 25/06/2024.
//


import Foundation


class StudentHomeworkVm : ObservableObject {
    @Published var studentExam : [StudentExamInfoDatum] = []
    @Published var studentExamS = ExamPargraphInfo()
    @Published var examParagraphsInfoData : [ExamParagraphsInfoData] = []
    @Published var genralVm : GeneralVm = GeneralVm()
    @Published var paragraphVm : ParagraphViewVm = ParagraphViewVm()
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var showExam : Bool = false
    @Published var paginated : Bool = false
    @Published var youAreNotstudenAlert : Bool = false
    @Published var showReview : Bool = false
    @Published var msg : String = ""
    @Published var remaingTime : Int = 0
    
    @Published var monthInputText: String = ""
    @Published var monthIsDropdownVisible = false
    @Published var monthSelectedOption: String = ""
    @Published var yearsInputText: String = ""
    @Published var yearsIsDropdownVisible = false
    @Published var yearsSelectedOption: String = ""
    let months = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    let years = ["2019", "2020","2021", "2022", "2023", "2024"]

    @Published var showingAlert = false
//    @Published var webView = WKWebView()
    @Published var backFromStudentHw : Bool = false
    @Published var showOpenAlert : Bool = false
    @Published var studentExamToken : String = ""
    
    var lang = Locale.current.language.languageCode!.identifier
    var constants = Constants()
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    var userToken = UserDefaultss().restoreString(key: "userToken")
    var totalPages = 1
    var currentPage = 1
    var firstDayOfMonth = ""
    var lastDayOfMonth = ""
    
    func getFirstAndLastDayOfMonth(year: Int, month: Int) -> (firstDay: Date, lastDay: Date)? {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!

        // Create date components for the first day of the given month and year
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1

        // Get the first day of the month
        guard let firstDay = calendar.date(from: components) else {
            return nil
        }

        // Get the range of days in the month
        guard let range = calendar.range(of: .day, in: .month, for: firstDay) else {
            return nil
        }

        // Calculate the last day of the month
        let lastDay = calendar.date(byAdding: .day, value: range.count - 1, to: firstDay)!

        return (firstDay, lastDay)
    }
    
    func stringToInt(_ string: String) -> Int? {
        return Int(string)
    }
    
    func getStudentHw(schudelToken:String, educationalGroupToken:String = "", moduleExamTypeToken:String = "" ,examSearchStatusTypeToken:String = ""){
            
        let month = stringToInt(monthSelectedOption)
        let year = stringToInt(yearsSelectedOption)
       
        
        if let result = getFirstAndLastDayOfMonth(year: year ?? 0, month: month ?? 0) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
             firstDayOfMonth = formatter.string(from: result.firstDay)
             lastDayOfMonth = formatter.string(from: result.lastDay)
        } else {
            print("Failed to get the first and last day of the month.")
        }
      
        self.isLoading = true
        
        do {
            let data = try JSONEncoder().encode(GeneralSearch())
            UserDefaults.standard.set(data, forKey: "apiData")
            do {
                
                let decoder = JSONDecoder()
                let data = try decoder.decode(GeneralSearch.self, from: data)
                data.userAuthorizeToken = self.authToken
                data.paginationStatus = "true"
                data.pageSize = self.constants.PAGE_SIZE
                data.page = currentPage
                data.activationTypeTokens = "AST-17400"
                data.filterStatus = "true"
                data.educationalGroupScheduleTimeToken = schudelToken
//                data.educationalGroupToken = educationalGroupToken
                data.userStudentToken = self.genralVm.userToken
                data.moduleExamTypeToken = moduleExamTypeToken
                data.examSearchStatusTypeToken = examSearchStatusTypeToken
                data.calendarSearchType = self.constants.CALENDER_SEARCH_TYPE_TOKEN_SIMPOL_CUSTOIZE
                data.dateTimeStartSearch = firstDayOfMonth
                data.dateTimeEndSearch = lastDayOfMonth
            
          
                do {
                    try Api().getStudentExams(generalSearch:data ,onCompletion: { status, msg, data,pagination in
                        if status == self.constants.STATUS_SUCCESS {
                            self.isLoading = false
                            self.noData = false
                            self.showLogOut = false
                            self.totalPages = pagination.totalPages ?? 1
                            if !self.paginated {
                                self.studentExam = []
                            }
                            self.studentExam.append(contentsOf: data)
                            
                        } else if status == self.constants.STATUS_INVALID_TOKEN {
                            self.isLoading = false
//                            self.noData = true
                            self.showLogOut = true
                            self.msg = msg
                        } else {
                            self.studentExam = []
                            self.showLogOut = false
                            self.isLoading = false
                            self.noData = true
                            self.msg = msg
                        }
                    })
                } catch {
                    self.studentExam = []
                    self.noData = true
                    self.isLoading = false
                    self.msg = error.localizedDescription
                }
                
            } catch {
                self.studentExam = []
                self.noData = true
                self.isLoading = false
                self.msg = error.localizedDescription
            }
            
            
        } catch {
            self.studentExam = []
            self.noData = true
            self.isLoading = false
            self.msg = error.localizedDescription
        }
    }

    
    func startHw(studentExamToken : String){
        self.isLoading = true
        do {
            try Api().startExam(authToken: self.authToken, token: studentExamToken) { status, msg, data in
                if status == self.constants.STATUS_SUCCESS {
                    self.isLoading = false
                 
                    self.examParagraphsInfoData = []
                    self.examParagraphsInfoData.append(contentsOf: (data.educationalExamInfoData?.examParagraphsInfoData)!)
                   
                    UserDefaultss().saveInt(value: data.remainingTimeinMilliseconds ?? 0, key: "remainingTimeinMilliseconds")
                    UserDefaultss().saveStrings(value: data.studentExamToken ?? "", key: "studentExamToken")
                    self.studentExamS = data
                  do {
                        let dataEncoded = try JSONEncoder().encode(data)
                        UserDefaults.standard.set(dataEncoded, forKey: "examParagraphsInfoData")
                    
                    } catch {
                        print("Error encoding data: \(error)")
                    }
                    self.noData = false
                    self.showLogOut = false
                    self.isLoading = false
                    self.showExam = true
                    UserDefaultss().removeObject(forKey: "examAnswersData")
                 
                } else if status == self.constants.STATUS_INVALID_TOKEN {
                    self.isLoading = false
                    self.showLogOut = true
                    self.msg = msg
                } else {
                    self.showLogOut = false
                    self.isLoading = false
                    self.noData = true
                    self.msg = msg
                }
            }
        } catch {
            self.noData = true
            self.isLoading = false
            self.msg = error.localizedDescription
        }
    }
    
    func reviewHw(studentExamToken : String){
        self.isLoading = true
        do {
            try Api().reviewExam(authToken: self.authToken, token: studentExamToken) { status, msg, data in
                if status == self.constants.STATUS_SUCCESS {
                    self.isLoading = false
                 
                    self.examParagraphsInfoData = []
                    self.examParagraphsInfoData.append(contentsOf: (data.educationalExamInfoData?.examParagraphsInfoData)!)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1 , execute: {
                        self.noData = false
                        self.showLogOut = false
                        self.showReview = true
                        UserDefaultss().removeObject(forKey: "examAnswersData")
                    })
                 
                 
                } else if status == self.constants.STATUS_INVALID_TOKEN {
                    self.isLoading = false
                    self.showLogOut = true
                    self.msg = msg
                } else {
                    self.showLogOut = false
                    self.isLoading = false
                    self.noData = true
                    self.msg = msg
                }
            }
        } catch {
            self.noData = true
            self.isLoading = false
            self.msg = error.localizedDescription
        }
    }

    
    func clearStatesWithAction(valueState: inout Bool) {
       valueState.toggle()
       UserDefaultss().removeObject(forKey: "selectedTag")
       self.backFromStudentHw = false
       self.youAreNotstudenAlert = false
   }
}
