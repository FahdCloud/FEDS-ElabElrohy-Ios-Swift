// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getStudentCoursesModel = try? JSONDecoder().decode(GetStudentCoursesModel.self, from: jsonData)

import Foundation

// MARK: - GetStudentCoursesModel
struct GetStudentCoursesModel :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var activationStatistics: ActivationStatistics?
    var pagination: Pagination?
    var educationalCourseStudentsData: [EducationalCourseStudentsDatum]?
}



// MARK: - EducationalCourseStudentsDatum
struct EducationalCourseStudentsDatum :Codable{
    var educationalCourseStudentToken: String?
    var refundTypeToken: String?
    var refundTypeNameCurrent: String?
    var educationalCourseToken: String?
    var educationalCourse: EducationalCourseInfoData?
    var userStudentToken: String?
    var userStudentInfoData: UserData?
    var dailyCode: Int?
    var fullCode: String?
    var activationTypeToken: String?
    var activationTypeNameCurrent: String?
    var timeZoneName: String?
    var createdByUserToken: String?
    var userCreatedData: UserData?
    var creationDateTime: String?
    var creationDateTimeCustomized: String?
    var creationDate: String?
    var creationTime: String?
    var lastUpdatedByUserToken: String?
    var userLastUpdatedData: UserDataInfo?
    var lastUpdateDateTime: String?
    var lastUpdateDateTimeCustomized: String?
    var lastUpdateDate: String?
    var lastUpdateTime: String?
}


