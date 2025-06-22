//
//  EducationGroupTimesMedia.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 30/10/2023.
//

import Foundation


// MARK: - EducationGroueTimeMediaModel
struct EducationGroueTimeMediaModel:Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var activationStatistics: ActivationStatistics?
    var pagination: Pagination?
    var systemMediaData: [SystemMediaDatum]?
}



// MARK: - SystemMediaDatum
struct SystemMediaDatum :Codable{
    var systemMediaToken: String?
    var systemMediaTitle: String?
    var systemMediaNotes: String?
    var systemMediaTypeToken: String?
    var systemMediaTypeNameCurrent: String?
    var storageFileToken: String?
    var storageFileData: StorageFileData?
    var educationalGroupScheduleTimeToken: String?
    var educationalGroupScheduleTimeInfoData: EducationalGroupScheduleTimeInfoData?
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

