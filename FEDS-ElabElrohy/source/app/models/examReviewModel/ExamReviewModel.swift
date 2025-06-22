// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let examReviewModel = try? JSONDecoder().decode(ExamReviewModel.self, from: jsonData)

import Foundation

// MARK: - ExamReviewModel
struct ExamReviewModel :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var studentExamInfoData: ExamReviewInfoData?
}

// MARK: - StudentExamInfoData
struct ExamReviewInfoData :Codable{
    var studentExamToken: String?
    var systemFinalDegree: Double?
    var systemPercentage: Double?
    var examStartDateTime: String?
    var examStartDateTimeCustomized: String?
    var examStartDate: String?
    var examStartTime: String?
    var examDeliveryStatusTypeToken: String?
    var examDeliveryStatusTypeNameCurrent: String?
    var examDeliveryDateTime: String?
    var examDeliveryDateTimeCustomized: String?
    var examDeliveryDate: String?
    var examDeliveryTime: String?
    var examDeliveredAfterTime: Bool?
    var canStartExam: Bool?
    var whyCanNotStartExam: String?
    var userStudentInfoData: UserStudentInfoData?
    var educationalExamInfoData: EducationalExamInfoData?
}



// MARK: - ParagraphQuestionsWithAnswer
struct ParagraphQuestionsWithAnswer :Codable{
    var isTrueAnswer: Bool?
    var studentAnswer: String?
    var systemTrueAnswer: String?
    var questionSolutionMethod: String?
    var paragraphQuestionToken: String?
    var questionDegree: Double?
    var questionTitle: String?
    var questionTypeToken: String?
    var questionTypeNameCurrent: String?
    var opationsMCQ: [String]?
}

