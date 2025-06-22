//
//  EducationAttendanceHistoryModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 24/10/2023.
//

import Foundation


// MARK: - EducationalAttendnaceHistoryModel
struct EducationalAttendnaceHistoryModel :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var activationStatistics: ActivationStatistics?
    var pagination: Pagination?
    var educationalGroupAttendancesData: [EducationalGroupAttendancesDatum]?
}


// MARK: - EducationalGroupAttendancesDatum
struct EducationalGroupAttendancesDatum :Codable{
    var educationalGroupAttendanceToken: String?
    var attendanceTypeToken: String?
    var attendanceTypeNameCurrent: String?
    var attendanceNotes: String?
    var attendanceRateNotes: String?
    var attendanceRate: Double?
    var joiningApplicationSubscriptionToken: String?
    var userStudentToken: String?
    var userStudentInfoData: UserData?
    var educationalGroupScheduleTimeToken: String?
    var educationalGroupScheduleTimeInfoData: EducationalGroupScheduleTimeInfoData?
    var attendanceStudentWarningData: AttendanceStudentWarningData?
    var attendaceBySession: AttendaceBySession?
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
    var educationalGroupInfoData : EducationalGroupInfoData?
    var userServiceProviderInfoData : UserServiceProviderInfoData?
    var educationalCategoryInfoData : EducationalCategoryInfoData?
}

// MARK: - AttendaceBySession
struct AttendaceBySession :Codable{
    var attendaceBySession: Bool?
    var sessionAmount: Double?
    var amountPayments: Double?
    var appendToDebtsStatus: Bool?
}

// MARK: - EducationalGroupScheduleTimeInfoData
struct EducationalGroupScheduleTimeInfoData:Codable{
    var educationalGroupScheduleTimeToken: String?
    var dayToken: String?
    var dayNameCurrent: String?
    var dateTimeFrom: String?
    var dateTimeFromCustomized: String?
    var dateTimeFromDate: String?
    var dateTimeFromTime: String?
    var dateTimeTo: String?
    var dateTimeToCustomized: String?
    var dateTimeToDate: String?
    var dateTimeToTime: String?
    var durationCurrent: String?
    var appointmentTypeToken: String?
    var appointmentTypeNameCurrent: String?
    var educationalGroupToken: String?
    var placeToken: String?
    var userServiceProviderToken: String?
    var zoomMeetingToken: String?
}

