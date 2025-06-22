//
//  SubmitExamModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/11/2023.
//

import Foundation


// MARK: - SubmitExam
struct SubmitExam :Codable{
    var userAuthorizeToken: String?
    var studentExamToken: String?
    var questionAnswers: [QuestionAnswer]?
}

// MARK: - QuestionAnswer
struct QuestionAnswer :Codable{
    var paragraphQuestionToken: String?
    var studentQuestionAnswer: String?
}
