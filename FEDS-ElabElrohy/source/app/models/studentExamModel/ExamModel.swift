//
//  ExamModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 02/11/2023.
//

import Foundation

// MARK: - ExamModel
struct ExamModel :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var startStudentExamData: ExamPargraphInfo?
}

// MARK: - StartStudentExamData
struct ExamPargraphInfo: Codable {
    var serverNowDateTime: String?
    var serverNowDateTimeCustomized: String?
    var serverNowDate: String?
    var serverNowTime: String?
    var remainingTimeinMilliseconds: Int?
    var studentExamToken: String?
    var educationalExamInfoData: EducationalExamInfoData?
}


// MARK: - ExamParagraphsInfoDatum
struct ExamParagraphsInfoData :Codable {
    var examParagraphToken: String?
    var examParagraphTitle: String?
    var examParagraphDescription: String?
    var examParagraphDegrees: Double?
    var examParagraphCountQuestions: Int?
    var paragraphQuestionsWithoutAnswer: [ParagraphQuestionsWithoutAnswer]?
    var paragraphQuestionsWithAnswer: [ParagraphQuestionsWithAnswer]?
}

// MARK: - ParagraphQuestionsWithoutAnswer
struct ParagraphQuestionsWithoutAnswer :Codable {
    var paragraphQuestionToken: String?
    var questionDegree: Double?
    var questionTitle: String?
    var questionTypeToken: String?
    var questionTypeNameCurrent: String?
    var opationsMCQ: [String]?
}

struct mcqQuestions {
    var paragraphQuestionToken: String?
    var questionDegree: Int?
    var questionTitle: String?
    var questionTypeToken: String?
    var questionTypeNameCurrent: String?
    var opationsMCQ: [String]?
}
struct trueFalseQuestions {
    var paragraphQuestionToken: String?
    var questionDegree: Int?
    var questionTitle: String?
    var questionTypeToken: String?
    var questionTypeNameCurrent: String?
//    var opationsMCQ: [String]?
}

struct ExamStudentModelCourse : Codable {
    var status : Int?
    var msg : String?
    var studentExamToken : String?
}
