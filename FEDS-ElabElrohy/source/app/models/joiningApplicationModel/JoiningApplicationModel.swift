//
//  JoiningApplicationModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 12/10/2023.
//

import Foundation


// MARK: - KnownMethodModel
struct JoiningApplicationModel :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var pagination: Pagination?
    var educationalJoiningApplicationsStatistics: EducationalJoiningApplicationsStatistics?
    var educationalJoiningApplicationsData: [EducationalJoiningApplicationsDatum]?
}

struct EducationalJoiningApplicationsStatistics : Codable {
    var totalUnderReviewCount: Int?
    var totalAcceptedCount: Int?
    var totalRejectedCount: Int?
    var underReviewPercentage: Double?
    var underReviewPercentageText: String?
    var acceptedPercentage: Double?
    var acceptedPercentageText: String?
    var rejectedPercentage: Double?
    var rejectedPercentageText: String?
    var totalCount: Int?
    var totalActiveCount: Int?
    var totalBlockedCount: Int?
    var totalActivePercentage: Double?
    var totalActivePercentageText: String?
    var totalBlockedPercentage: Double?
    var totalBlockedPercentageText: String?
}
// MARK: - EducationalJoiningApplicationsDatum
struct EducationalJoiningApplicationsDatum :Codable{
    var educationalJoiningApplicationToken: String?
    var educationalJoiningApplicationTitleCurrent: String?
    var educationalJoiningApplicationDescriptionCurrent: String?
    var educationalJoiningApplicationDescriptionAr: String?
    var educationalJoiningApplicationDescriptionEn: String?
    var discountPercentageFromTotal: Double?
    var discountPercentageFromEnterprise: Double?
    var discountPercentageFromServiceProvider: Double?
    var termToken: String?
    var termDescriptionCurrent: String?
    var termDescriptionAr: String?
    var termDescriptionEn: String?
    var canRelatedTypeToken: String?
    var canRelatedTypeNameCurrent: String?
    var approvalTypeToken: String?
    var approvalTypeNameCurrent: String?
    var approvalDataTime: String?
    var approvalDataTimeCustomized: String?
    var approvalData: String?
    var approvalTime: String?
    var approvalNote: String?
    var rejectReasonCurrent: String?
    var approvalUserInfoData: UserAtedData?
    var educationalCategoryToken: String?
    var educationalCategoryInfoData: EducationalCategoryInfoData?
    var educationalCategoryTreeData: TreesDatum?
    var knownMethodToken: String?
    var knownMethodInfoData: KnownMethodsDatum?
    var userStudentToken: String?
    var userStudentInfoData: UserStudentInfoData?
    var userPreferredServiceProviderToken: String?
    var userPreferredServiceProviderInfoData: UserAtedData?
    var userPreferredPlaceToken: String?
//    var userPreferredPlaceInfoData: PlaceTree?
//    var joiningApplicationSubscriptionInfo: NSNull?
    var dailyCode: Int?
    var fullCode: String?
    var activationTypeToken: String?
    var activationTypeNameCurrent: String?
    var timeZoneName: String?
    var createdByUserToken: String?
    var userCreatedData: UserDataInfo?
    var creationDateTime: String?
    var creationDateTimeCustomized: String?
    var creationDate: String?
    var creationTime: String?
    var lastUpdatedByUserToken: String?
    var userLastUpdatedData: UserAtedData?
    var lastUpdateDateTime: String?
    var lastUpdateDateTimeCustomized: String?
    var lastUpdateDate: String?
    var lastUpdateTime: String?
}


// MARK: - UserStudentInfoData
struct UserStudentInfoData :Codable {
    var userToken: String?
    var userNameCurrent: String?
    var fullCode: String?
    var userTypeToken: String?
    var userTypeNameCurrent: String?
    var userImageIsDefault: Bool?
    var userImageURL: String?
    var userImageSizeBytes: Int?
    var userThumbnailImageURL: String?
    var userThumbnailImageSizeBytes: Int?
}

