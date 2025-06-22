//
//  educationCoursDetailsVm.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 30/10/2023.
//

import Foundation

import BottomSheetSwiftUI
import SwiftUI

@available(iOS 16.0, *)
class EducationCourseDetailsVm : ObservableObject {
    
    @Published var studentExam : [StudentExamInfoDatum] = []
    @Published var examParagraphsInfoData : [ExamParagraphsInfoData] = []
    @Published var genralVm : GeneralVm = GeneralVm()
    @Published var paragraphVm : ParagraphViewVm = ParagraphViewVm()
    
    @Published var examSubmittedSuccess : Bool = false
    @Published var openSheet = false
    @Published var reloadCourseInfo = false
    @Published var isLoading : Bool = false
    @Published var noData : Bool = false
    @Published var msg : String = ""
    @Published var showLogOut : Bool = false
    @Published var showCourseInfoTabView : Bool = false
    @Published var showExam : Bool = false
    @Published var showReview : Bool = false
    
    @Published var toast: Toast? = nil
    @Published var msgDialogExam : String = ""
    
    @Published var bottomSheetPositionCourseCode: BottomSheetPosition = .hidden
    @Published var bottomSheetPositionWalletCode: BottomSheetPosition = .hidden
    @Published var bottomSheetPositionAcadmicYearCode: BottomSheetPosition = .hidden
    @Published var bottomSheetPositionPackagePrice: BottomSheetPosition = .hidden


    @Published var educationalCourseData : EducationalCourseInfoData = EducationalCourseInfoData()
    @Published var educationalSubscription : EducationalCourseStudentSubscription = EducationalCourseStudentSubscription()
    
    @Published var  userFinanceStatisticData : UserFinanceStatisticData = UserFinanceStatisticData()
    @Published var  educationalCourseModel : EducationalCourseModel = EducationalCourseModel()
    
    @Published var educationalCourseLevelsData : [EducationalCourseLevelsDatum] = []
    @Published var studentExamVm : StudentExamVm = StudentExamVm()
   
    @Published var courseToken = UserDefaultss().restoreString(key: "courseToken")
    
    var constants = Constants()
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    var userToken = UserDefaultss().restoreString(key: "userToken")

    
    func getEducationCourseDetails(token : String){
        
        self.isLoading = true
        
        do {
            try Api().getEducationCourseDetails(userAuth: self.genralVm.authToken, userStudentToken: self.genralVm.userToken, token: token) { status, msg, data in
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    self.getFinanceData()
                    self.noData = false
                    self.educationalCourseData = data
                    
                    do {
                        let dataEncoded = try JSONEncoder().encode(data)
                        UserDefaults.standard.set(dataEncoded, forKey: "educationalCourseInfoData")
                    
                    } catch {
                        print("Error encoding data: \(error)")
                    }
                    
                } else if status == self.genralVm.constants.STATUS_INVALID_TOKEN || status == self.genralVm.constants.STATUS_VERSION {
                    self.isLoading = false
                    self.showLogOut = true
                    self.msg = msg
                    Helper.removeUserDefaultsAndCashes()
                    UserDefaults.standard.set(msg, forKey: "logoutMsg")
                    
                } else {
                    self.isLoading = false
                    self.noData = true
                    self.msg = msg
                }
            }

        } catch {
            self.isLoading = false
            self.msg = error.localizedDescription
        }
    }
    
    func getFinanceData(){
        do {
            try Api().getUserFinanceData(authToken : self.genralVm.authToken,userToken: self.genralVm.userToken ,onCompletion: { status, msg, data in
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    self.isLoading = false
                    self.userFinanceStatisticData = data
                }else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                            status == self.genralVm.constants.STATUS_VERSION {
                    self.isLoading = false
                    self.showLogOut = true
                    self.msg = msg
                    Helper.removeUserDefaultsAndCashes()
                    UserDefaults.standard.set(msg, forKey: "logoutMsg")
                    
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
    
    func imageForMediaType(_ mediaType: String, constants: Constants , lessonTypeToken : String) -> Image {
        if lessonTypeToken == constants.LESSONS_TYPE_TOKEN_EXAM {
            return Image("exams")
        } else {
            switch mediaType {
            case constants.MEDIA_TYPE_VIDEO:
                return Image("svg-video")
            case constants.MEDIA_TYPE_PDF:
                return Image("svg-pdf")
            case constants.MEDIA_TYPE_WORD:
                return Image("svg-word")
            case constants.MEDIA_TYPE_VOICE:
                return Image("svg-voice")
            case constants.MEDIA_TYPE_IMAGE:
                return Image("svg-image")
            case constants.MEDIA_TYPE_EXCEl:
                return Image("svg-excel")
            case constants.MEDIA_TYPE_POWERPOINT:
                return Image("svg-powerPoint")
            case constants.MEDIA_TYPE_LINK:
                return Image("link")
            default:
                return Image("svg-other")
            }
        }
    }
    
    func buyCourseFromBalance(educationalCourseData : EducationalCourseInfoData ){
        self.isLoading = true
        do {
            try Api().buyCourse(authToken: self.genralVm.authToken, userStudentToken: self.genralVm.userToken, educationalCourseToken: educationalCourseData.educationalCourseToken ?? "",
                                amountBePaid: educationalCourseData.educationalCoursePrice ?? 0 )
            { status, msg in
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    self.isLoading = false
                    self.bottomSheetPositionPackagePrice = .hidden
                    self.getEducationCourseDetails(token: self.courseToken)
                    self.msg = msg
                    self.toast = Helper.showToast(style: .success, message: msg)
                    self.showCourseInfoTabView.toggle()
                }  else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                            status == self.genralVm.constants.STATUS_VERSION {
                    self.isLoading = false
                    self.showLogOut = true
                    self.msg = msg
                    Helper.removeUserDefaultsAndCashes()
                    UserDefaults.standard.set(msg, forKey: "logoutMsg")
                } else {
                    self.showLogOut = false
                    self.isLoading = false
                    self.msg = msg
                    self.toast = Helper.showToast(style: .error, message: msg)
                }
            }
        }  catch {
            self.isLoading = false
            self.msg = error.localizedDescription
            self.toast = Helper.showToast(style: .error, message: msg)
        }
    }
    
    
    func buyCourseFromPackage(educationalCourseData : EducationalCourseInfoData, coursePrice : Double ){
        self.isLoading = true
        do {
            try Api().buyCourse(authToken: self.genralVm.authToken, userStudentToken: self.genralVm.userToken, educationalCourseToken: educationalCourseData.educationalCourseToken ?? "",
                                amountBePaid: coursePrice )
            { status, msg in
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    self.isLoading = false
                    self.bottomSheetPositionPackagePrice = .hidden
                    self.getEducationCourseDetails(token: self.courseToken)
                    self.msg = msg
                    self.toast = Helper.showToast(style: .success, message: msg)
                    self.showCourseInfoTabView.toggle()
                }  else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                            status == self.genralVm.constants.STATUS_VERSION {
                    self.isLoading = false
                    self.showLogOut = true
                    self.msg = msg
                    Helper.removeUserDefaultsAndCashes()
                    UserDefaults.standard.set(msg, forKey: "logoutMsg")
                } else {
                    self.showLogOut = false
                    self.isLoading = false
                    self.msg = msg
                    self.toast = Helper.showToast(style: .error, message: msg)
                }
                
            }
        }  catch {
            self.isLoading = false
            self.msg = error.localizedDescription
            self.toast = Helper.showToast(style: .error, message: msg)
        }
        
    }
    
    
    func buyCourseFromCourseCode(educationalCourseData : EducationalCourseInfoData , code: String){
        self.isLoading = true
        do {
            try Api().buyCourseFromCourseCode(authToken: self.genralVm.authToken,
                                              userStudentToken: self.genralVm.userToken,
                                              educationalCourseToken: educationalCourseData.educationalCourseToken ?? "",
                                              coursePurchaseType: genralVm.constants.CoursePurchaseType_CourseCode,
                                              code:  code)
            { status, msg in
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    
                    self.isLoading = false
                    self.bottomSheetPositionPackagePrice = .hidden
                    self.bottomSheetPositionCourseCode = .hidden
                    self.toast = Helper.showToast(style: .success, message: msg)
                    self.getEducationCourseDetails(token: self.courseToken)
                    self.msg = msg
                    self.showCourseInfoTabView.toggle()
                }  else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                            status == self.genralVm.constants.STATUS_VERSION {
                    self.isLoading = false
                    self.showLogOut = true
                    self.msg = msg
                    Helper.removeUserDefaultsAndCashes()
                    UserDefaults.standard.set(msg, forKey: "logoutMsg")
                } else {
                    self.showLogOut = false
                    self.isLoading = false
                    self.msg = msg
                    self.toast = Helper.showToast(style: .error, message: msg)

                }
                
            }
        }  catch {
            self.isLoading = false
            self.msg = error.localizedDescription
            self.toast = Helper.showToast(style: .error, message: msg)
        }
        
    }
    
    func buyCourseFromAcademicYearCode(educationalCourseData : EducationalCourseInfoData , code: String){
        self.isLoading = true
        do {
            try Api().buyCourseFromAcademicYearCode(authToken: self.genralVm.authToken,
                                              userStudentToken: self.genralVm.userToken,
                                              educationalCourseToken: educationalCourseData.educationalCourseToken ?? "",
                                              coursePurchaseType: genralVm.constants.CoursePurchaseType_AcademicYearCode,
                                              code:  code)
            { status, msg in
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    
                    self.isLoading = false
                    self.bottomSheetPositionPackagePrice = .hidden
                    self.bottomSheetPositionAcadmicYearCode = .hidden
                    self.getEducationCourseDetails(token: self.courseToken)
                    self.msg = msg
                    self.toast = Helper.showToast(style: .success, message: msg)
                    self.showCourseInfoTabView.toggle()
                }  else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                            status == self.genralVm.constants.STATUS_VERSION {
                    self.isLoading = false
                    self.showLogOut = true
                    self.msg = msg
                    Helper.removeUserDefaultsAndCashes()
                    UserDefaults.standard.set(msg, forKey: "logoutMsg")
                } else {
                    
                    self.showLogOut = false
                    self.isLoading = false
                    self.msg = msg
                    self.toast = Helper.showToast(style: .error, message: msg)
                }
                
            }
        }  catch {
            self.isLoading = false
            self.msg = error.localizedDescription
            self.toast = Helper.showToast(style: .error, message: msg)
        }
        
    }
    
    func buyCourseFromWalletCode(educationalCourseData : EducationalCourseInfoData , code: String){
        self.isLoading = true
        do {
            try Api().buyCourseFromWalletCode(authToken: self.genralVm.authToken,
                                              userStudentToken: self.genralVm.userToken,
                                              educationalCourseToken: educationalCourseData.educationalCourseToken ?? "",
                                              coursePurchaseType: genralVm.constants.CoursePurchaseType_CourseCode,
                                              code:  code)
            { status, msg in
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    
                    self.isLoading = false
                    self.bottomSheetPositionPackagePrice = .hidden
                    self.bottomSheetPositionWalletCode = .hidden
                    self.getEducationCourseDetails(token: self.courseToken)
                    self.msg = msg
                    self.toast = Helper.showToast(style: .success, message: msg)
                    self.showCourseInfoTabView.toggle()
                }  else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                            status == self.genralVm.constants.STATUS_VERSION {
                    self.isLoading = false
                    self.showLogOut = true
                    self.msg = msg
                    Helper.removeUserDefaultsAndCashes()
                    UserDefaults.standard.set(msg, forKey: "logoutMsg")
                } else {
                    
                    self.showLogOut = false
                    self.isLoading = false
                    self.msg = msg
                    self.toast = Helper.showToast(style: .error, message: msg)
                }
                
            }
        }  catch {
            self.isLoading = false
            self.msg = error.localizedDescription
            self.toast = Helper.showToast(style: .error, message: msg)
        }
        
    }
    
    
    func requestExam(educationalCourseLessonToken:String ,educationalCourseStudentToken:String){
        self.isLoading = true
        do {
            try Api().requestExam(userAuthorizeToken: self.genralVm.authToken, languageToken: Language.getLanguageISO(), educationalCourseLessonToken: educationalCourseLessonToken, educationalCourseStudentToken: educationalCourseStudentToken)
            { status, msg  ,studentExamToken in
                if status == self.genralVm.constants.STATUS_SUCCESS {
                    
                    self.isLoading = false
                    self.startExam(studentExamToken: studentExamToken)
                   self.msg = msg
                }  else if status == self.genralVm.constants.STATUS_INVALID_TOKEN ||
                            status == self.genralVm.constants.STATUS_VERSION {
                    self.isLoading = false
                    self.showLogOut = true
                    self.msg = msg
                    Helper.removeUserDefaultsAndCashes()
                    UserDefaults.standard.set(msg, forKey: "logoutMsg")
                } else {
                    
                    self.showLogOut = false
                    self.isLoading = false
                    self.msg = msg
                    self.toast = Helper.showToast(style: .error, message: msg)
                    self.reloadCourseInfo = true

                }
                
            }
        }  catch {
            self.isLoading = false
            self.msg = error.localizedDescription
            self.toast = Helper.showToast(style: .error, message: msg)
        }
    }
    
    func startExam(studentExamToken : String){
        self.isLoading = true
        do {
            try Api().startExam(authToken: self.authToken, token: studentExamToken) { status, msg, data in
             
                if status == self.constants.STATUS_SUCCESS {
                  
                    self.examParagraphsInfoData = []
                    self.examParagraphsInfoData.append(contentsOf: (data.educationalExamInfoData?.examParagraphsInfoData)!)
                   
                        do {
                            UserDefaultss().saveInt(value: data.remainingTimeinMilliseconds ?? 0, key: "remainingTimeinMilliseconds")
                            UserDefaultss().saveStrings(value: data.studentExamToken ?? "", key: "studentExamToken")
                            
                        let dataEncoded = try JSONEncoder().encode(data)
                            UserDefaults.standard.set(dataEncoded, forKey: "examParagraphsInfoData")
                            self.noData = false
                            self.showLogOut = false
                            self.showExam = true
                            UserDefaultss().removeObject(forKey: "examAnswersData")
                            self.toast = Helper.showToast(style: .success, message: msg)
                            self.isLoading = false
                        } catch {
                            self.toast = Helper.showToast(style: .success, message: error.localizedDescription)
                           
                        }
                       
                } else if status == self.constants.STATUS_INVALID_TOKEN {
                    self.isLoading = false
                    self.showLogOut = true
                    self.msg = msg
                   
                } else {
                    self.showLogOut = false
                    self.isLoading = false
                    self.noData = true
                    self.msg = msg
                   self.toast = Helper.showToast(style: .error, message: msg)
                    self.reloadCourseInfo = true
                }
            }
        } catch {
            self.noData = true
            self.isLoading = false
            self.msg = error.localizedDescription
            
            self.toast = Helper.showToast(style: .error, message: msg)
        }
    }
    
    
    func reviewExam(studentExamToken : String){
        self.isLoading = true
        do {
            try Api().reviewExam(authToken: self.authToken, token: studentExamToken) { status, msg, data in
                if status == self.constants.STATUS_SUCCESS {
                    UserDefaultss().removeObject(forKey: "examAnswersData")
                    self.examParagraphsInfoData = []
                    self.examParagraphsInfoData.append(contentsOf: (data.educationalExamInfoData?.examParagraphsInfoData)!)
                    
                    do {
                        let dataEncoded = try JSONEncoder().encode(data)
                        UserDefaults.standard.set(dataEncoded, forKey: "examParagraphsInfoData")
                    
                    } catch {
                        print("Error encoding data: \(error)")
                    }
                    self.noData = false
                    self.showLogOut = false
                    self.showReview = true
                    self.isLoading = false

                    
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
