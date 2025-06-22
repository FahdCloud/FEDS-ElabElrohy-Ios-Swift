//
//  EducationalSchudelModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 11/09/2023.
//

import Foundation




// MARK: - EducationCategory
struct EducationCategorySchudel {
    var educationalCategoryToken: String?
    var fullCode: String?
    var educationalCategoryNameCurrent: String?
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
    var educationalGroups: [EducationalGroup]?
}

// MARK: - EducationalGroup
struct EducationalGroup {
  
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
    var educationalSchuldeTimes: [EducationalSchuldeTimes]?
}

// MARK: - EducationalSchuldeTimes
struct EducationalSchuldeTimes {
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

struct ZoomMeetingData :Codable{
    var zoomMeetingToken: String?
      var zoomMeetingId: String?
      var meetingTitle: String?
      var dateTimeStart: String?
      var dateTimeStartCustomized: String?
      var dateTimeStartDate: String?
      var dateTimeStartTime: String?
      var dateTimeEnd: String?
      var dateTimeEndCustomized: String?
      var dateTimeEndDate: String?
      var dateTimeEndTime: String?
      var lastUpdateDateTime: String?
      var creationDateTime: String?
      var creationDateTimeCustomized: String?
      var creationDate: String?
      var creationTime: String?
      var durationMinutes: Int?
      var hostUrl: String?
      var joinUrl: String?
}
struct PlaceInfoData :Codable{
    var placeToken: String?
    var fullCode: String?
    var placeNameCurrent: String?
    var placeDescriptionCurrent: String?
    var placeImageIsDefault: Bool?
    var placeImageUrl: String?
    var placeFullNameCurrent: String?
    var placeImageSizeBytes: Int?
    var placeThumbnailImageUrl: String?
    var placeThumbnailImageSizeBytes: Int?
    var parentPlaceToken: String?
    var mainRootToken: String?
    var rankingUnderParent: Int?
    var isHaveChildrenStatus: Bool?
}
