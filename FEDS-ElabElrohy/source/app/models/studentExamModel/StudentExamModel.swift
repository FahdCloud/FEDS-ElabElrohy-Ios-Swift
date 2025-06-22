//
//  StudentExamModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 02/11/2023.
//

import Foundation


// MARK: - EducationGroupModel
struct EducationStudentExamsModel :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var pagination: Pagination?
    var studentExamInfoData: [StudentExamInfoDatum]?
}


// MARK: - StudentExamInfoDatum
struct StudentExamInfoDatum :Codable{
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
    var canStartExam : Bool?
    var whyCanNotStartExam: String?
    var examDeliveredAfterTime: Bool?
    var userStudentInfoData: UserStudentInfoData?
    var educationalExamInfoData: EducationalExamInfoData?
}

// MARK: - EducationalExamInfoData
struct EducationalExamInfoData:Codable {
    var educationalExamToken: String?
    var educationalExamTitle: String?
    var canStartsAnyTime: Bool?
    var examIsHaveSolutionDuration: Bool?
    var canSolutionDurationByMinute: Int?
    var studentWillSucceedFromPercentage: Double?
    var educationalExamStartDateTime: String?
    var educationalExamStartCustomized: String?
    var educationalExamStartDate: String?
    var educationalExamStartTime: String?
    var educationalExamEndDateTime: String?
    var educationalExamEndCustomized: String?
    var educationalExamEndDate: String?
    var educationalExamEndTime: String?
    var durationCurrent: String?
    var countQuestionParagraphs: Int?
    var countQuestions: Int?
    var totalDegrees: Double?
    var moduleExamTypeToken: String?
    var solutionMethodStorageFileToken: String?
    var solutionMethodStorageFileData: StorageFileData?
    var educationalCategoryToken: String?
    var educationalCategoryInfoData: EducationalCategoryInfoData?
    var educationalGroupToken: String?
    var educationalGroupInfoData: EducationalGroupInfoData?
    var educationalGroupScheduleTimeToken: String?
    var educationalGroupScheduleTimeInfoData: EducationalGroupScheduleTimeInfoData?
    var educationalCourseToken: String?
    var examParagraphsInfoData: [ExamParagraphsInfoData]?
}
