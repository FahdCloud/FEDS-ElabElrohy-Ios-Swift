//
//  JoiningAppDetailsModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 18/12/2023.
//

import Foundation


// MARK: - JoiningAppDetails
struct JoiningAppDetails:Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var educationalJoiningApplication: EducationalJoiningApplication?
}

// MARK: - EducationalJoiningApplication
struct EducationalJoiningApplication :Codable{
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
    var approvalTypeToken: String?
    var approvalTypeNameCurrent: String?
    var approvalDataTime: String?
    var approvalDataTimeCustomized: String?
    var approvalData: String?
    var approvalTime: String?
    var approvalNote: String?
    var rejectReasonCurrent: String?
    var approvalUserInfoData: ApprovalUserInfoDataClass?
    var educationalCategoryToken: String?
    var educationalCategoryInfoData: EducationalCategoryInfoData?
    var userStudentToken: String?
    var userStudentInfoData: UserDataInfo?
    var userPreferredServiceProviderToken: String?
    var userPreferredServiceProviderInfoData: UserServiceProviderInfoData?
    var dailyCode: Int?
    var fullCode: String?
    var activationTypeToken: String?
    var activationTypeNameCurrent: String?
    var timeZoneName: String?
    var createdByUserToken: String?
    var userCreatedData: ApprovalUserInfoDataClass?
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

// MARK: - ApprovalUserInfoDataClass
struct ApprovalUserInfoDataClass :Codable{
    var userToken: String?
    var userNameCurrent: String?
    var userDescriptionCurrent: String?
    var fullCode: String?
    var userTypeToken: String?
    var userTypeNameCurrent: String?
    var userImageIsDefault: Bool?
    var userImageUrl: String?
    var userImageSizeBytes: Int?
    var userThumbnailImageUrl: String?
    var userThumbnailImageSizeBytes: Int?
}
