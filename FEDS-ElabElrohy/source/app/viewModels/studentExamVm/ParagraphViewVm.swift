//
//  ParagraphViewVm.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Mrwan on 25/06/2024.
//

import Foundation
import BottomSheetSwiftUI

class ParagraphViewVm : ObservableObject {
    @Published private var genralVm : GeneralVm = GeneralVm()
    @Published var examParagraphsInfoData : [ExamParagraphsInfoData] = []
    @Published var educationGroupTimeToken : String = ""
    @Published var examParagraphInfoData : ExamParagraphsInfoData = ExamParagraphsInfoData()
    @Published var paragraphQuestionWithoutAnswers : [ParagraphQuestionsWithoutAnswer] = []
    @Published var startStudentExamData : ExamPargraphInfo = ExamPargraphInfo()
    
    @Published var hasLoaded : Bool = false
    @Published var backGeasture : Bool = false
    @Published var showQuestions : Bool = false
    @Published var showLoading : Bool = false
    @Published var toggleAnswerFalse : Bool = false
    @Published var toggleAnswerRight : Bool = false
    @Published var examSubmittedSuccess : Bool = false
    @Published var showMCQList = false
    @Published var showTrueFalseList = false
    
    
    @Published var sucessMsg : String = ""
    @Published var toast: Toast? = nil
    @Published var currentQuestionIndex = 0
    @Published var selectedAnswerIndex: Int?
    @Published var selectedParagraph: ExamParagraphsInfoData?
    @Published var lang = Locale.current.language.languageCode!.identifier
    @Published var mcqList: [ParagraphQuestionsWithoutAnswer] = []
    @Published var trueFalseList: [ParagraphQuestionsWithoutAnswer] = []
    @Published var answersFinished = [QuestionAnswer]()
    @Published var isReview = UserDefaultss().restoreBool(key: "isReview")
    @Published var isDark = UserDefaultss().restoreBool(key: "isDark")
    @Published var studentExamToken = UserDefaultss().restoreString(key: "studentExamToken")
    @Published var remainingTimeinMilliseconds = UserDefaultss().restoreInt(key: "remainingTimeinMilliseconds")
    @Published var questionAnswer :String = ""
    @Published var selectedOptions: [String: String] = [:]
    @Published var selectedOptionsTf: [String: String] = [:]
    @Published var timer: Timer?
    
    func separateQuestions(paragraphs: [ParagraphQuestionsWithoutAnswer]) -> ([ParagraphQuestionsWithoutAnswer], [ParagraphQuestionsWithoutAnswer]) {
        let mcqList = paragraphs.filter { $0.questionTypeToken == "QST-2" }
        let trueFalseList = paragraphs.filter { $0.questionTypeToken == "QST-1" }
        
        return (mcqList, trueFalseList)
    }
    
    func clearStatesWithAction(valueState: inout Bool) {
        valueState.toggle()
        backGeasture = false
        
    }
    
    func submitExam(){
        self.showLoading = true
        let savedData = UserDefaults.standard.data(forKey: "examAnswersData")
        if savedData != nil {
            do {
                let decoder = JSONDecoder()
                let loadedExamAnswers = try decoder.decode(SubmitExam.self, from: savedData!)
                
                do {
                    try Api().submitExam(statusEncoding: true, data: loadedExamAnswers) { status, msg in
                        
                        if status == Constants().STATUS_SUCCESS {
                            UserDefaultss().removeObject(forKey: "studentExamToken")
                            UserDefaultss().removeObject(forKey: "remainingTimeinMilliseconds")
                            UserDefaultss().removeObject(forKey: "examParagraphsInfoData")
                            UserDefaultss().removeObject(forKey: "examAnswersData")
                            self.sucessMsg = msg
                            self.examSubmittedSuccess = true
                            self.showLoading = false
//                            URLCache.shared.removeAllCachedResponses()
//                            exit(0)
                        } else if status == Constants().STATUS_ERROR {
                            self.showLoading = false
                            
                            self.toast = Helper.showToast(style: .error, message: msg)
                            
                        } else if status == Constants().STATUS_CATCH {
                            self.showLoading = false
                            
                            self.toast = Helper.showToast(style: .error, message: msg)
                            
                        } else if status == Constants().STATUS_NO_CONTENT {
                            self.showLoading = false
                            self.toast = Helper.showToast(style: .error, message: msg)
                            
                        } else {
                            self.showLoading = false
                            self.toast = Helper.showToast(style: .error, message: msg)
                            
                        }
                    }
                    
                    
                } catch {
                    self.showLoading = false
                    self.toast = Helper.showToast(style: .error, message: error.localizedDescription)
                    
                }
                
            } catch {
                self.showLoading = false
                self.toast = Helper.showToast(style: .error, message:  error.localizedDescription)
            }
        }else{
            
            self.showLoading = false
            
            self.toast = Helper.showToast(style: .error, message: NSLocalizedString("msg_no_answer", comment: ""))
        }
        
        
        
        
    }
    
    func  getAndSetQuestions(pragraph : ExamParagraphsInfoData){
        if let data = UserDefaults.standard.data(forKey: "examAnswersData"){
            do {
                let decoder = JSONDecoder()
                let selectedData = try decoder.decode(SubmitExam.self, from: data)
                self.answersFinished = selectedData.questionAnswers ?? self.answersFinished
                if !isReview {
                    for selected in self.answersFinished {
                        if self.answersFinished.count > 0 {
                            if selected.paragraphQuestionToken == pragraph.paragraphQuestionsWithoutAnswer![currentQuestionIndex].paragraphQuestionToken ?? "" {
                                self.questionAnswer = selected.studentQuestionAnswer ?? ""
                            }
                        }
                    }
                } else {
                    for selected in self.answersFinished {
                        if self.answersFinished.count > 0 {
                            if selected.paragraphQuestionToken == pragraph.paragraphQuestionsWithAnswer![currentQuestionIndex].paragraphQuestionToken ?? "" {
                                self.questionAnswer = selected.studentQuestionAnswer ?? ""
                            }
                        }
                    }
                }
            } catch {
                Helper.traceCrach(error: error, userToken: "")
            }
        }
    }
    
    func saveAnswers(questionToken:String,answerToken : String,pragraph : ExamParagraphsInfoData){
        let answers = [QuestionAnswer(paragraphQuestionToken: questionToken, studentQuestionAnswer: answerToken)]
        
        do {
            let data = try JSONEncoder().encode(SubmitExam())
            UserDefaults.standard.set(data, forKey: "keys")
            
            do {
                let decoder = JSONDecoder()
                var examAnswersData = try decoder.decode(SubmitExam.self, from: data)
                examAnswersData.userAuthorizeToken = self.genralVm.authToken
                examAnswersData.studentExamToken = self.studentExamToken
                
                let removedItem = self.answersFinished.contains(where: { $0.paragraphQuestionToken == questionToken })
                if removedItem {
                    self.answersFinished.removeAll { x in
                        return x.paragraphQuestionToken == questionToken
                    }
                    self.answersFinished.append(contentsOf: answers)
                    self.questionAnswer = questionToken
                } else {
                    self.answersFinished.append(contentsOf: answers)
                    self.questionAnswer = questionToken
                }
                examAnswersData.questionAnswers = self.answersFinished
                
                
                do {
                    let encoder = JSONEncoder()
                    let finishedData = try encoder.encode(examAnswersData)
                    UserDefaults.standard.set(finishedData, forKey: "examAnswersData")
                    
                    getAndSetQuestions(pragraph: pragraph)
                } catch {
                    Helper.traceCrach(error: error, userToken: "")
                }
                
            } catch {
                Helper.traceCrach(error: error, userToken: "")
            }
            
        } catch {
            Helper.traceCrach(error: error, userToken: "")
        }
    }
    
    func setMcqTfQuestions() {
        self.currentQuestionIndex = 0
        let (mcq, trueFalse) = separateQuestions(paragraphs: self.selectedParagraph?.paragraphQuestionsWithoutAnswer ?? [])
        self.mcqList = mcq
        self.trueFalseList = trueFalse
    }
    
    
 

}
