//
//  StorageFileData.swift
//  FEDS-Center-Dev
//
//  Created by Omar Pakr on 10/02/2024.
//

import Foundation

// MARK: - StorageFileData
struct StorageFileData:Codable {
    var storageFileToken: String?
    var storageFileTitle: String?
    var thumbnailImageUrl: String?
    var watchViewUrl: String?
    var moduleNameTypeToken: String?
    var serverStorageTypeToken: String?
    var serverStorageType: String?
    var storageFileMediaTypeToken: String?
    var totalSizeBytes: Int?
    var storageFileSizeBytes: Int?
    var storageFileThumbnailImageSizeBytes: Int?
    var ownedUserToken: String?
    var storageFolderToken: String?
    var lastUpdateDateTime: String?
    var creationDateTime: String?
    var storageFileStatistic: StorageFileStatistic?
    var youtubeData: YoutubeData?
    
}

struct StorageFileStatistic:Codable {
    var totalSizeSizeBytes: Int64?
    var totalSizeSizeText: String?
    var numberTimesRequested: Int64?
}

struct YoutubeData:Codable {
    var youtubeVideoId: String?
    var durationVideo: Double?
}
