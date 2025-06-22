//
//  KnowMethodModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 10/10/2023.
//

import Foundation

// MARK: - KnownMethodModel
struct KnownMethodModel :Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var activationStatistics: ActivationStatistics?
    var pagination: Pagination?
    var knownMethodsData: [KnownMethodsDatum]?
}


// MARK: - KnownMethodsDatum
struct KnownMethodsDatum : Codable {
    var knownMethodToken: String?
    var knownMethodNameCurrent: String?
    var knownMethodNameAr: String?
    var knownMethodNameEn: String?
    var knownMethodDescriptionCurrent: String?
    var knownMethodDescriptionAr: String?
    var knownMethodDescriptionEn: String?
    var knownMethodImageIsDefault: Bool?
    var knownMethodImageURL: String?
    var knownMethodImageSizeBytes: Int?
    var knownMethodThumbnailImageURL:String?
    var knownMethodThumbnailImageSizeBytes:Int?
    var dailyCode:Int?
    var fullCode: String?
    var activationTypeToken: String?
    var activationTypeNameCurrent: String?
    var timeZoneName: String?
    var createdByUserToken: String?
    var userCreatedData: UserDataInfo?
    var creationDateTime:String?
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

