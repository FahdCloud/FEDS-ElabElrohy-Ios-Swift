//
//  EducationCategoryModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 05/10/2023.
//

import Foundation


// MARK: - EducationCategoryTreeModel
struct EducationCategoryTreeModel:Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var cachToken: String?
    var activationStatistics: ActivationStatistics?
    var treesData: [TreesDatum]?
}

// MARK: - ActivationStatistics
struct ActivationStatistics :Codable{
    var totalCount: Int?
    var totalActiveCount: Int?
    var totalBlockedCount: Int?
    var totalActivePercentage: Double?
    var totalActivePercentageText: String?
    var totalBlockedPercentage: Double?
    var totalBlockedPercentageText: String?
}

// MARK: - TreesDatum
struct TreesDatum :Codable{
    var key: String?
    var label: String?
    var data: DataClass?
    var children: [TreesDatum]?
}

// MARK: - DataClass
struct DataClass :Codable{
    var itemToken: String?
    var itemParentToken: String?
    var itemMainRootToken: String?
    var itemNameCurrent: String?
    var itemNameAr: String?
    var itemNameEn: String?
    var itemDescriptionCurrent: String?
    var itemDescriptionAr: String?
    var itemDescriptionEn: String?
    var itemLevel: Int?
    var fullPathUnderParent: String?
    var isHaveChildrenStatus: Bool?
    var itemImageIsDefault: Bool?
    var itemImageUrl: String?
    var itemThumbnailImageUrl: String?
    var dailyCode: Int?
    var fullCode: String?
    var userCreatedData: UserAtedData?
    var creationDateTime: String?
    var creationDateTimeCustomized: String?
    var creationDate: String?
    var creationTime: String?
    var userLastUpdatedData: UserAtedData?
    var lastUpdateDateTime: String?
    var lastUpdateDateTimeCustomized: String?
    var lastUpdateDate: String?
    var lastUpdateTime: String?
    var activationTypeToken: String?
    var activationTypeNameCurrent: String?
    var activationTypeNameAr: String?
    var activationTypeNameEn: String?

}

// MARK: - UserAtedData
struct UserAtedData :Codable{
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
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let educationCategoriesCRUD = try? JSONDecoder().decode(EducationCategoriesCRUD.self, from: jsonData)

import Foundation

// MARK: - EducationCategoriesCRUD
struct EducationCategoriesCRUD :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var activationStatistics: ActivationStatistics?
    var pagination: Pagination?
    var currentEducationalCategoryToken: String?
    var prevEducationalCategoryToken: String?
    var educationalCategoriesData: [EducationalCategoriesDatum]?
}



// MARK: - EducationalCategoriesDatum
struct EducationalCategoriesDatum:Codable {
    var educationalCategoryToken: String?
    var educationalCategoryNameCurrent: String?
    var educationalCategoryNameAr: String?
    var educationalCategoryNameEn: String?
    var educationalCategoryFullNameCurrent: String?
    var educationalCategoryFullNameAr: String?
    var educationalCategoryFullNameEn: String?
    var educationalCategoryDescriptionCurrent: String?
    var educationalCategoryDescriptionAr: String?
    var educationalCategoryDescriptionEn: String?
    var educationalCategoryImageIsDefault: Bool?
    var educationalCategoryImageUrl: String?
    var educationalCategoryImageSizeBytes: Int?
    var educationalCategoryThumbnailImageUrl: String?
    var educationalCategoryThumbnailImageSizeBytes: Int?
    var parentEducationalCategoryToken: String?
//    var parentEducationalCategoryInfoData: Education?
    var mainRootToken: String?
    var rankingUnderParent: Int?
    var isHaveChildrenStatus: Bool?
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
    var userLastUpdatedData: UserDataInfo?
    var lastUpdateDateTime: String?
    var lastUpdateDateTimeCustomized: String?
    var lastUpdateDate: String?
    var lastUpdateTime: String?
}
