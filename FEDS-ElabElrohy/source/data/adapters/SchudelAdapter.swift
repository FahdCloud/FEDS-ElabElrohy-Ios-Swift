//
//  SchudelAdapter.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 11/09/2023.
//

import Foundation

class schudelAdpater {
   
    public static func adapte(allScudles : [UserEducationalGroupScheduleTimesDatum]) -> [EducationCategorySchudel] {
        var educationCategorySchudle : [EducationCategorySchudel] = []
        let allCategories : [EducationalCategoryInfoData] = groupEducationalGategories(allSchudel: allScudles)
        for category in allCategories {
            let item = EducationCategorySchudel(educationalCategoryToken: category.educationalCategoryToken, fullCode: category.fullCode, educationalCategoryNameCurrent: category.educationalCategoryNameCurrent, educationalCategoryDescriptionCurrent: category.educationalCategoryDescriptionCurrent, educationalCategoryImageIsDefault: category.educationalCategoryImageIsDefault, educationalCategoryImageUrl: category.educationalCategoryImageUrl, educationalCategoryImageSizeBytes: category.educationalCategoryImageSizeBytes, educationalCategoryThumbnailImageUrl: category.educationalCategoryThumbnailImageUrl, educationalCategoryThumbnailImageSizeBytes: category.educationalCategoryThumbnailImageSizeBytes, parentEducationalCategoryToken: category.parentEducationalCategoryToken, mainRootToken: category.mainRootToken, rankingUnderParent: category.rankingUnderParent, isHaveChildrenStatus: category.isHaveChildrenStatus, educationalGroups: getGroupOfEducationalCategories(allSchudel: allScudles, educationalCategoryToken: category.educationalCategoryToken!))
            educationCategorySchudle.append(item)
        }
        return educationCategorySchudle
    }
    
    private static func groupEducationalGategories(allSchudel : [UserEducationalGroupScheduleTimesDatum]) -> [EducationalCategoryInfoData] {
        let allCategories: [EducationalCategoryInfoData] = allSchudel.map { $0.educationalCategoryInfoData! }
        let noRepeatCategories: [EducationalCategoryInfoData] = Array(Set(allCategories))
        let finalData: [EducationalCategoryInfoData] = noRepeatCategories.sorted {
            (allCategories.firstIndex(of: $0) ?? 0) < (allCategories.firstIndex(of: $1) ?? 0)
        }
        return finalData
    }
    
    private static func getGroupOfEducationalCategories(allSchudel : [UserEducationalGroupScheduleTimesDatum],educationalCategoryToken :String) -> [EducationalGroup] {
        var educationGroupList : [EducationalGroup] = []
        var uniqueGroupTokens = Set<String>() // Set to track unique group tokens
        let allGroups: [EducationalGroupInfoData] = allSchudel.filter() {$0.educationalCategoryInfoData?.educationalCategoryToken == educationalCategoryToken}.map { $0.educationalGroupInfoData! }
        for group in allGroups {
            guard let groupToken = group.educationalGroupToken, !uniqueGroupTokens.contains(groupToken) else {
                continue // Skip if the group is already added
            }
            uniqueGroupTokens.insert(groupToken) // Add token to the set
            let item = EducationalGroup(educationalGroupToken: group.educationalGroupToken, fullCode: group.fullCode, countStudents: group.countStudents, educationalGroupNameCurrent: group.educationalGroupNameCurrent, educationalGroupDescriptionCurrent: group.educationalGroupDescriptionCurrent, educationalGroupFinishTypeToken: group.educationalGroupFinishTypeToken, educationalGroupFinishTypeNameCurrent: group.educationalGroupFinishTypeNameCurrent, educationalGroupClosedStateTypeToken: group.educationalGroupClosedStateTypeToken, educationalGroupClosedStateTypeNameCurrent: group.educationalGroupClosedStateTypeNameCurrent, educationalGroupImageIsDefault: group.educationalGroupImageIsDefault, educationalGroupImageUrl: group.educationalGroupImageUrl, educationalGroupImageSizeBytes: group.educationalGroupImageSizeBytes, educationalGroupThumbnailImageUrl: group.educationalGroupThumbnailImageUrl, educationalGroupThumbnailImageSizeBytes: group.educationalGroupThumbnailImageSizeBytes, educationalSchuldeTimes: getSchuldTimeOfEducationalGroup(allSchudel: allSchudel, educationalGroupToken: group.educationalGroupToken!))
            educationGroupList.append(item)
        }
        return educationGroupList
    }
    
    private static func getSchuldTimeOfEducationalGroup(allSchudel : [UserEducationalGroupScheduleTimesDatum],educationalGroupToken :String) -> [EducationalSchuldeTimes] {
        var schuldeTimesList : [EducationalSchuldeTimes] = []
        let allSchuldeTimes: [UserEducationalGroupScheduleTimesDatum] = allSchudel.filter() {$0.educationalGroupToken! == educationalGroupToken}
        for schuldeTimes in allSchuldeTimes {
            let item = EducationalSchuldeTimes(educationalGroupScheduleTimeToken: schuldeTimes.educationalGroupScheduleTimeToken, appointmentNotes: schuldeTimes.appointmentNotes, dayToken: schuldeTimes.dayToken, dayNameCurrent: schuldeTimes.dayNameCurrent, dateTimeFrom: schuldeTimes.dateTimeFrom, dateTimeFromCustomized: schuldeTimes.dateTimeFromCustomized, dateTimeFromDate: schuldeTimes.dateTimeToDate, dateTimeFromTime: schuldeTimes.dateTimeFromTime, dateTimeTo: schuldeTimes.dateTimeTo, dateTimeToCustomized: schuldeTimes.dateTimeToCustomized, dateTimeToDate: schuldeTimes.dateTimeToDate, dateTimeToTime: schuldeTimes.dateTimeToTime, durationCurrent: schuldeTimes.durationCurrent, appointmentTypeToken: schuldeTimes.appointmentTypeToken, appointmentTypeNameCurrent: schuldeTimes.appointmentTypeNameCurrent, educationalGroupToken: schuldeTimes.educationalGroupToken, placeToken: schuldeTimes.placeToken, placeInfoData: schuldeTimes.placeInfoData, userServiceProviderToken: schuldeTimes.userServiceProviderToken, userServiceProviderInfoData: schuldeTimes.userServiceProviderInfoData, zoomMeetingToken: schuldeTimes.zoomMeetingToken, zoomMeetingData: schuldeTimes.zoomMeetingData, attendanceTypeToken: schuldeTimes.attendanceTypeToken, attendanceTypeNameCurrent: schuldeTimes.attendanceTypeNameCurrent, attendanceNotes: schuldeTimes.attendanceNotes, attendanceRateNotes: schuldeTimes.attendanceRateNotes, attendanceRate: schuldeTimes.attendanceRate, attendanceStudentWarningData: schuldeTimes.attendanceStudentWarningData)
            schuldeTimesList.append(item)
        }
        return schuldeTimesList
    }
}

