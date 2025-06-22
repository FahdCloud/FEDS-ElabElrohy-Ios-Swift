//
//  AllMedia.swift
//  FEDS-Center-Dev
//
//  Created by Omar pakr on 27/01/2024.
//

import Foundation


// MARK: - AllMedia
struct AllMedia :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var activationStatistics: ActivationStatistics?
    var pagination: Pagination?
    var systemMediaData: [SystemMediaData]?
}



// MARK: - SystemMediaDatum
struct SystemMediaData :Codable{
    var systemMediaToken: String?
    var systemMediaTitle: String?
    var systemMediaNotes: String?
    var systemMediaTypeToken: String?
    var systemMediaTypeNameCurrent: String?
    var storageFileToken: String?
    var storageFileData: StorageFileDataMedia?
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

struct StorageFileDataMedia :Codable {
    var storageFileToken: String?
    var storageFileTitle: String?
    var watchViewUrl: String?
    var thumbnailImageUrl: String?
    var storageFileMediaTypeToken: String?
    var fileIsInprocess: Bool?
    var uploadFileIsDone: Bool?
    var uploadThumbnailIsDone: Bool?
    var storageFileSizeBytes: Int?
    var storageFileThumbnailImageSizeBytes: Int?
    var totalSizeSizeBytes: Int?
    var totalSizeSizeText: String?
    var creationDateTime: String?
    var creationDate: String?
    var creationTime: String?
    var ownedUserToken: String?
    var storageFolderToken: String?
}
