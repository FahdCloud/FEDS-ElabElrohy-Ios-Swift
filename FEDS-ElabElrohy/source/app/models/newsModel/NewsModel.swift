// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsModel = try? JSONDecoder().decode(NewsModel.self, from: jsonData)

import Foundation

// MARK: - NewsModel
struct NewsModel:Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var activationStatistics: ActivationStatistics?
    var pagination: Pagination?
    var newsArticlesData: [NewsArticlesDatum]?
}



// MARK: - NewsArticlesDatum
struct NewsArticlesDatum :Codable{
    var newsArticleToken: String?
    var newsArticleTitle: String?
    var newsArticleContent: String?
    var newsArticleTags: String?
    var storageFileToken: String?
    var storageFileData: StorageFileNews?
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


struct StorageFileNews:Codable {
    var storageFileToken: String?
    var storageFileTitle: String?
    var watchViewUrl: String?
    var thumbnailImageUrl: String?
    var moduleNameTypeToken: String?
    var serverStorageTypeToken: String?
    var storageFileMediaTypeToken: String?
    var totalSizeBytes: Int?
    var storageFileSizeBytes: Int?
    var storageFileThumbnailImageSizeBytes: Int?
    var ownedUserToken: String?
    var storageFolderToken: String?
    var lastUpdateDateTime: String?
    var creationDateTime: String?
}

