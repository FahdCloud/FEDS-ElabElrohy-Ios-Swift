//
//  TeacherGroupsModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 27/11/2023.
//

import Foundation


// MARK: - GetAllTeacherGroupsModel
struct GetAllTeacherGroupsModel:Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var pagination: Pagination?
    var educationalGroupsData: [EducationalGroupsDatum]?
}


// MARK: - EducationalGroupsDatum
struct EducationalGroupsDatum:Codable{
    var educationalGroupToken: String?
    var educationalGroupNumberInEducationalCategory: Int?
    var educationalGroupNameCurrent: String?
    var educationalGroupNameEn: String?
    var educationalGroupNameAr: String?
    var educationalGroupDescriptionCurrent: String?
    var educationalGroupDescriptionAr: String?
    var educationalGroupDescriptionEn: String?
    var educationalGroupFinishTypeToken: String?
    var educationalGroupFinishTypeNameCurrent: String?
    var educationalGroupClosedStateTypeToken: String?
    var educationalGroupClosedStateTypeNameCurrent: String?
    var educationalGroupMaximumStudentsNumber: Int?
    var educationalGroupMinimumStudentsNumber: Int?
    var educationalGroupImageIsDefault: Bool?
    var educationalGroupImageUrl: String?
    var educationalGroupImageSizeBytes: Int?
    var educationalGroupThumbnailImageUrl: String?
    var educationalGroupThumbnailImageSizeBytes: Int?
    var serviceProviderAmountValue: Double?
    var userServiceProviderToken: String?
    var userServiceProviderInfoData: UserData?
    var priceListToken: String?
    var priceListData: PriceListData?
    var educationalGroupStatisticsInfoData: EducationalGroupStatisticsInfoData?
    var educationalCategoryToken: String?
    var educationalCategoryInfoData: EducationalCategoryInfoData?
    var educationalCategoryTreeData: [TreesDatum]?
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

