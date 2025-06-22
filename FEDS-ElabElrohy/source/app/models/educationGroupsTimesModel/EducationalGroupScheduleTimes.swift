//
//  EducationGroupsSchudle.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/09/2023.
//

import Foundation


// MARK: - EducationalGroupScheduleTimes
struct EducationalGroupScheduleTimes : Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var pagination: Pagination?
    var userEducationalGroupScheduleTimesData: [UserEducationalGroupScheduleTimesDatum]?
}

// MARK: - ListSort
struct ListSort : Codable{
    var sortToken: String?
    var sortType: String?
    var propertyName: String?
    var sortNameCurrent: String?
    var sortNameAr: String?
    var sortNameEn: String?
}

// MARK: - Pagination
struct Pagination : Codable{
    var totalPages: Int?
    var totalItems: Int?
    var countItemsInPage: Int?
    var selfPage: Int?
    var firstPage: Int?
    var prevPage: Int?
    var nextPage: Int?
    var lastPage: Int?
}

// MARK: - UserEducationalGroupScheduleTimesDatum
struct UserEducationalGroupScheduleTimesDatum : Codable{
    var educationalGroupScheduleTimeToken: String?
    var appointmentNotes: String?
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
    var educationalGroupInfoData: EducationalGroupInfoData?
    var educationalCategoryInfoData: EducationalCategoryInfoData?
    var placeToken: String?
    var placeInfoData: PlaceInfoData?
    var userServiceProviderToken: String?
    var userServiceProviderInfoData: UserServiceProviderInfoData?
    var zoomMeetingToken: String?
    var zoomMeetingData: ZoomMeetingData?
    var attendanceTypeToken: String?
    var attendanceTypeNameCurrent: String?
    var attendanceNotes: String?
    var attendanceRateNotes: String?
    var attendanceRate: Double?
    var attendanceStudentWarningData: AttendanceStudentWarningData?
}

// MARK: - AttendanceStudentWarningData
struct AttendanceStudentWarningData : Codable{
    var countWarningText: String?
    var countTureWarning: Int?
    var warningStatus1: Bool?
    var warningStatus2: Bool?
    var warningStatus3: Bool?
    var warningStatus4: Bool?
    var warningStatus5: Bool?
    var warningNotes1: String?
    var warningNotes2: String?
    var warningNotes3: String?
    var warningNotes4: String?
    var warningNotes5: String?
}

// MARK: - EducationalCategoryInfoData
struct EducationalCategoryInfoData : Codable , Hashable{
    var educationalCategoryToken: String?
    var fullCode: String?
    var educationalCategoryNameCurrent: String?
    var educationalCategoryFullNameCurrent: String?
    var educationalCategoryDescriptionCurrent: String?
    var educationalCategoryImageIsDefault: Bool?
    var educationalCategoryImageUrl: String?
    var educationalCategoryImageSizeBytes: Int?
    var educationalCategoryThumbnailImageUrl: String?
    var educationalCategoryThumbnailImageSizeBytes: Int?
    var parentEducationalCategoryToken: String?
//    var parentEducationalCategoryInfoData: EducationalCategoryInfoData?
    var mainRootToken: String?
    var rankingUnderParent: Int?
    var isHaveChildrenStatus: Bool?
}

// MARK: - EducationalGroupInfoData
struct EducationalGroupInfoData : Codable,Hashable{
    var educationalGroupToken: String?
    var fullCode: String?
    var countStudents: Int?
    var educationalGroupNameCurrent: String?
    var educationalGroupDescriptionCurrent: String?
    var educationalGroupFinishTypeToken: String?
    var educationalGroupFinishTypeNameCurrent: String?
    var educationalGroupClosedStateTypeToken: String?
    var educationalGroupClosedStateTypeNameCurrent: String?
    var educationalGroupImageIsDefault: Bool?
    var educationalGroupImageUrl: String?
    var educationalGroupImageSizeBytes: Int?
    var educationalGroupThumbnailImageUrl: String?
    var educationalGroupThumbnailImageSizeBytes: Int?
}

// MARK: - UserServiceProviderInfoData
struct UserServiceProviderInfoData : Codable{
    var userToken: String?
    var userNameCurrent: String?
    var fullCode: String?
    var userTypeToken: String?
    var userTypeNameCurrent: String?
    var userImageIsDefault: Bool?
    var userImageUrl: String?
    var userImageSizeBytes: Int?
    var userThumbnailImageUrl: String?
    var userThumbnailImageSizeBytes: Int?
}
