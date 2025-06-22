//
//  BuyEducationalCoursModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 14/11/2023.
//

import Foundation


// MARK: - GetEducationCoursBuyModel
struct GetEducationCoursBuyModel :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var educationalCourseStudentData: EducationalCourseStudentData?
}

// MARK: - EducationalCourseStudentData
struct EducationalCourseStudentData:Codable {
    var educationalCourseStudentToken: String?
    var refundTypeToken: String?
    var refundTypeNameCurrent: String?
    var educationalCourseToken: String?
    var educationalCourse: EducationalCourseInfo?
    var userStudentToken: String?
    var userStudentInfoData: UserStudentInfoData?
    var dailyCode: Int?
    var fullCode: String?
    var activationTypeToken: String?
    var activationTypeNameCurrent: String?
    var timeZoneName: String?
    var createdByUserToken: String?
    var userCreatedData: String?
    var creationDateTime: String?
    var creationDateTimeCustomized: String?
    var creationDate: String?
    var creationTime: String?
    var lastUpdatedByUserToken: String?
    var userLastUpdatedData: String?
    var lastUpdateDateTime: String?
    var lastUpdateDateTimeCustomized: String?
    var lastUpdateDate: String?
    var lastUpdateTime: String?
}

