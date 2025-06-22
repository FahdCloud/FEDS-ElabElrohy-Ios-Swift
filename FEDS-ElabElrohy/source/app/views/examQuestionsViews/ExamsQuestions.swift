//
//  ExamsQuestions.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/11/2023.
//

import SwiftUI
import WebKit
import RichText

@available(iOS 16.0, *)
struct ExamsQuestionsMCQ: View {
    
    let constants = Constants()
    @State var lang = Locale.current.language.languageCode!.identifier
    @State var examParagraphsInfoData : [ExamParagraphsInfoData] = []
    @State var paragraphQuestionWithoutAnswers : [ParagraphQuestionsWithoutAnswer] = []
    @Binding var examParagraphInfoData : ExamParagraphsInfoData
    @State var questionAnswer :String = ""
    @State var dateTimeInSecond : Int64 = 0
    @State private var currentQuestionIndex = 0
    @State var backGeasture : Bool = false
    @State var answersFinished = [QuestionAnswer]()
    var educationGroupTimeToken = UserDefaultss().restoreString(key: "educationGroupTimeToken")
    @State private var remainingTime: Int = UserDefaultss().restoreInt(key: "remainingTime")
    @State private var remainingMilliseconds: Int = 0
    var authToken = UserDefaultss().restoreString(key: "userAuth")
    let studentExamToken = UserDefaultss().restoreString(key: "studentExamToken")
    let timeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    let isReview = UserDefaultss().restoreBool(key: "isReview")

    var body: some View {
    NavigationView {
        VStack {
            Spacer()
            VStack {
                
                Text(examParagraphInfoData.examParagraphTitle ?? "")
                    .font(.title)
//                
//                if !isReview {
//                    Text("\(DateTime.formattedTime(remainingTime))")
//                        .onAppear(perform: {
//                            _ = self.timer
//                        })
//                }
                
              
                
                Text(examParagraphInfoData.examParagraphDescription ?? "")
                    .font(.subheadline)
                    .padding()
            }
            
            HStack {
                Text(NSLocalizedString("dgree", comment: ""))
                
                Text("\(Helper.formateDouble(rate:examParagraphInfoData.examParagraphDegrees ?? 0.0))")
            }
            
            
            HStack {
                Text(NSLocalizedString("que", comment: ""))
                
                Text("\(currentQuestionIndex + 1)")
            }
            .font(.headline)
            
            
            if ( !isReview ? (examParagraphInfoData.paragraphQuestionsWithoutAnswer?[currentQuestionIndex].questionTypeToken) : (examParagraphInfoData.paragraphQuestionsWithAnswer?[currentQuestionIndex].questionTypeToken) ) == "QST-2" {
                if !isReview {
                    VStack {
                        RichText(html:examParagraphInfoData.paragraphQuestionsWithoutAnswer?[currentQuestionIndex].questionTitle ?? "")
                            .font(.body)
                            .padding()
                        
                        if let options = examParagraphInfoData.paragraphQuestionsWithoutAnswer?[currentQuestionIndex].opationsMCQ {
                            ScrollView {
                                ForEach(options,id:\.self) { option in
                                    HStack(alignment: .center, spacing: 5) {
                                        
                                        Button {
                                            if !isReview {
                                                saveAnswers(questionToken: examParagraphInfoData.paragraphQuestionsWithoutAnswer?[currentQuestionIndex].paragraphQuestionToken ?? "", answerToken: option,pragraph:self.examParagraphInfoData)
                                            }
                                        } label: {
                                            RichText(html:option)
                                            
                                        }
                                        .frame(width: 234, height: 58, alignment: .center)
                                    }
                                    
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .frame(width: 234, height: 58, alignment: .center)
                                    .background(self.questionAnswer == "\(option)" ? .green : .cyan)
                                    .background(.green)
                                    .cornerRadius(10)
                                }
                            }
                            .frame(width: 234, height: 300, alignment: .center)
                            .onAppear {
                                    getAndSetQuestions(pragraph: self.examParagraphInfoData)
                            }
                        }
                        
                    }

                } else {
                    VStack {
                        RichText(html:examParagraphInfoData.paragraphQuestionsWithAnswer?[currentQuestionIndex].questionTitle ?? "")
                            .font(.body)
                            .padding()
                        
                        if let options = examParagraphInfoData.paragraphQuestionsWithAnswer?[currentQuestionIndex].opationsMCQ {
                            ScrollView {
                                ForEach(options,id:\.self) { option in
                                    HStack(alignment: .center, spacing: 5) {
                                        
                                        Button {
                                           
                                        } label: {
                                            RichText(html:option)
                                            
                                        }
                                        .frame(width: 234, height: 58, alignment: .center)
                                    }
                                    
                                    .multilineTextAlignment(.center)
                                    .lineLimit(2)
                                    .frame(width: 234, height: 58, alignment: .center)
                                    .background(self.questionAnswer == "\(option)" ? .green : .cyan)
                                    .background(.green)
                                    .cornerRadius(10)
                                }
                            }
                            .frame(width: 234, height: 300, alignment: .center)
                            .onAppear {
                                    getAndSetQuestions(pragraph: self.examParagraphInfoData)
                            }
                        }
                    }
                }

            } else {
                if !isReview {
                    VStack {
                        RichText(html:examParagraphInfoData.paragraphQuestionsWithoutAnswer?[currentQuestionIndex].questionTitle ?? "")
                            .font(.body)
                            .padding()
                        
                        
                        VStack (spacing:50){
                            HStack(alignment: .center, spacing: 5) {
                                Button {
                                    if !isReview {
                                        saveAnswers(questionToken: examParagraphInfoData.paragraphQuestionsWithoutAnswer?[currentQuestionIndex].paragraphQuestionToken ?? "", answerToken: "true",pragraph:self.examParagraphInfoData)
                                    }
                                } label: {
                                    Text(NSLocalizedString("yes", comment: ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .foregroundColor(.black)
                                }
                            }
                            
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .padding(.horizontal, 82)
                            .padding(.vertical, 16)
                            .frame(width: 234, height: 58, alignment: .center)
                            .background(self.questionAnswer == "true" ? .green : .cyan)
                            .cornerRadius(10)
                            
                            HStack(alignment: .center, spacing: 5) {
                                Button {
                                    if !isReview {
                                        saveAnswers(questionToken: examParagraphInfoData.paragraphQuestionsWithoutAnswer?[currentQuestionIndex].paragraphQuestionToken ?? "", answerToken: "false",pragraph:self.examParagraphInfoData)
                                    }
                                } label: {
                                    Text(NSLocalizedString("no", comment: ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .foregroundColor(.black)
                                }
                            }
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .padding(.horizontal,82)
                            .padding(.vertical,16)
                            .frame(width: 234,height: 58, alignment: .center)
                            .background(self.questionAnswer == "false" ? .green : .cyan)
                            .cornerRadius(10)
                        }
                        .frame(width: 234, height: 300, alignment: .center)
                        .onAppear {
                            if isReview {
                                // set the answer of student
                            } else {
                                getAndSetQuestions(pragraph: self.examParagraphInfoData)
                            }
                        }
                    }
                    
                } else {
                    VStack {
                        RichText(html:examParagraphInfoData.paragraphQuestionsWithAnswer?[currentQuestionIndex].questionTitle ?? "")
                            .font(.body)
                            .padding()
                        
                        
                        VStack (spacing:50){
                            HStack(alignment: .center, spacing: 5) {
                                Button {
                                  
                                } label: {
                                    Text(NSLocalizedString("yes", comment: ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .foregroundColor(.black)
                                }
                            }
                            
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .padding(.horizontal, 82)
                            .padding(.vertical, 16)
                            .frame(width: 234, height: 58, alignment: .center)
                            .background(self.questionAnswer == "true" ? .green : .cyan)
                            .cornerRadius(10)
                            
                            HStack(alignment: .center, spacing: 5) {
                                Button {
                                    
                                } label: {
                                    Text(NSLocalizedString("no", comment: ""))
                                        .font(
                                            Font.custom(Fonts().getFontBold(), size: 15)
                                                .weight(.bold)
                                        )
                                        .foregroundColor(.black)
                                }
                            }
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .padding(.horizontal,82)
                            .padding(.vertical,16)
                            .frame(width: 234,height: 58, alignment: .center)
                            .background(self.questionAnswer == "false" ? .green : .cyan)
                            .cornerRadius(10)
                        }
                        .frame(width: 234, height: 300, alignment: .center)
                        .onAppear {
                            getAndSetQuestions(pragraph: self.examParagraphInfoData)
                        }
                    }

                }
            }
            
            Spacer()
            
            HStack (spacing:100) {
                Button {
                    if !isReview {
                        if currentQuestionIndex < self.examParagraphInfoData.paragraphQuestionsWithoutAnswer!.count - 1 {
                            currentQuestionIndex += 1
                            getAndSetQuestions(pragraph: self.examParagraphInfoData)
                        }
                    } else {
                        if currentQuestionIndex < self.examParagraphInfoData.paragraphQuestionsWithAnswer!.count - 1 {
                            currentQuestionIndex += 1
                        }
                    }
                } label: {
                    Image(systemName: self.lang == "ar" ? "arrow.right" : "arrow.left")
                }
                
                Button {
                    if currentQuestionIndex != 0 {
                        currentQuestionIndex -= 1
                        getAndSetQuestions(pragraph: self.examParagraphInfoData)
                    }
                } label: {
                    Image(systemName: self.lang == "ar" ? "arrow.left" : "arrow.right")
                }
            }
            .padding(.bottom,100)
        }
                
                .navigationTitle(NSLocalizedString("ques", comment: ""))
                .navigationBarItems(
                    leading: HStack(spacing: 10){
                    if self.lang == constants.APP_IOS_LANGUAGE_AR  {
                        Image("arrow-right")
                            .resizable()
                            .frame(width: 30,height: 30)
                        
                        
                    }else {
                        Image("arrow-left")
                            .resizable()
                            .frame(width: 30,height: 30)
                    }
                    
                    Text(NSLocalizedString("back", comment: ""))
                        .foregroundColor(Color.gray)
                        .font(
                            Font.custom(Fonts().getFontBold(), size: 20)
                                .weight(.bold)
                        )
                    
                }
                    .onTapGesture {
                        self.backGeasture.toggle()
                    }
                )
                .onAppear(perform: {
                    getAndSetQuestions(pragraph: self.examParagraphInfoData)
                })
                .fullScreenCover(isPresented: $backGeasture , content: {
                    ParagraphView()
                })
        }
    }
    
    private var timer: Timer {
         Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
             if self.remainingTime > 0 {
                 self.remainingTime -= 1000
                 UserDefaultss().saveInt(value: self.remainingTime, key: "remainingTime")
             } else {
                 // Timer expired, stop the timer or perform any other desired action
             }
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
    
    private func saveAnswers(questionToken:String,answerToken : String,pragraph : ExamParagraphsInfoData){
        let answers = [QuestionAnswer(paragraphQuestionToken: questionToken, studentQuestionAnswer: answerToken)]
        
        do {
            let data = try JSONEncoder().encode(SubmitExam())
            UserDefaults.standard.set(data, forKey: "keys")
            
            do {
                let decoder = JSONDecoder()
                var examAnswersData = try decoder.decode(SubmitExam.self, from: data)
                examAnswersData.userAuthorizeToken = self.authToken
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

    func formatTime(milliseconds: Int) -> String {
        let totalSeconds = milliseconds / 1000
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

