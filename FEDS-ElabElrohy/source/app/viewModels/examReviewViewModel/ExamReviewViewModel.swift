//
//  ExamReviewViewModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 17/12/2023.
//

import Foundation

class ExamReviewViewModel : ObservableObject {
    @Published var studentExamReview : ExamReviewInfoData = ExamReviewInfoData()
    @Published var studentExamS = ExamPargraphInfo()
    @Published var examParagraphsInfoData : [ExamParagraphsInfoData] = []
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var showLogOut : Bool = false
    @Published var showExam : Bool = false
    @Published var msg : String = ""
    @Published var remaingTime : Int = 0
    
    
    var lang = Locale.current.language.languageCode!.identifier
    var constants = Constants()
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    var userToken = UserDefaultss().restoreString(key: "userToken")
    var totalPages = 1
    var currentPage = 1
    
    func getStudentExamsReview(studentExamToken:String){
       
        self.isLoading = true
                do {
                    try Api().getStudentExamReview(userAuthorizeToken: self.authToken, studentExamToken: studentExamToken ,onCompletion: { status, msg, data in

                        if status == self.constants.STATUS_SUCCESS {
                            self.studentExamReview = data
                            self.examParagraphsInfoData.append(contentsOf: (data.educationalExamInfoData?.examParagraphsInfoData)!)
                            self.isLoading = false
                            self.noData = false
                            self.showLogOut = false
                         
                        } else if status == self.constants.STATUS_INVALID_TOKEN {
                            self.isLoading = false
//                            self.noData = true
                            self.showLogOut = true
                            self.msg = msg
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
        
    }

    
    func startExam(studentExamToken : String){
        self.isLoading = true
        do {
            try Api().startExam(authToken: self.authToken, token: studentExamToken) { status, msg, data in
              
                                
                if status == self.constants.STATUS_SUCCESS {
                    self.isLoading = false
                    self.noData = false
                    self.showLogOut = false
//                    self.showExam = true
                    self.examParagraphsInfoData = []
                    self.examParagraphsInfoData.append(contentsOf: (data.educationalExamInfoData?.examParagraphsInfoData)!)
                    self.remaingTime = data.remainingTimeinMilliseconds ?? 0
                    self.studentExamS = data
                    
                 
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
}
