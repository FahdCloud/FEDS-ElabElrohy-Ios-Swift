//
//  EducationCoursModel.swift
//  FEDS-Dev-1.1
//
//  Created by Mrwan on 26/08/2024.
//

import Foundation


// MARK: - EducationalCourseModel
struct EducationalCourseModel :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var activationStatistics: ActivationStatistics?
    var pagination: Pagination?
    var educationalCourseVMData: [EducationalCourseVMDatum]?
}


// MARK: - EducationalCourseVMDatum
struct EducationalCourseVMDatum :Codable{
    var educationalCourseToken: String?
    var educationalCourseNameCurrent: String?
    var educationalCourseNameAr: String?
    var educationalCourseNameEn: String?
    var educationalCourseDescriptionCurrent: String?
    var educationalCourseDescriptionEn: String?
    var educationalCourseDescriptionAr: String?
    var educationalCourseNaturePurchaseType: String?
    var storageFileToken: String?
    var storageFileData: StorageFileData?
    var thumbnailImageForVideo: Bool?
    var educationalCourseThumbnailImageUrl: String?
    var storageFileWatchViewUrl: String?
    var percentageForServiceProvider: Int?
    var percentageForEstablishment: Int?
    var educationalCoursePrice: Double?
    var educationalCoursePriceWithCurrency: String?
    var availableByDateTimeStatus: Bool?
    var availableDateTimeFromCustomized: String?
    var availableDateTimeToCustomized: String?
    var userServiceProviderInfoData: UserServiceProviderInfoData?
    var educationalCategoryCustomInfoData: EducationalCategoryCustomInfoData?
    var educationalCourseStatsticInfoData: EducationalCourseStatsticInfoData?
    var educationalCourseSubscriptionPlans: [EducationalCourseSubscriptionPlan]?
    var dailyCode: String?
    var fullCode: String?
    var activationTypeToken: String?
    var activationTypeNameCurrent: String?
    var createdByUserToken: String?
    var userCreatedData: UserAtedData?
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
    var lastUpdateFromText: String?
}

// MARK: - EducationalCourseStatsticInfoData
struct EducationalCourseStatsticInfoData :Codable{
    var countChapters: Int?
    var countLessones: Int?
    var countExames: Int?
    var countFiles: Int?
    var countStudentsEnrolled: Int?
    var countStatsOfReview: Int?
    var countStudentsDoReview: Int?
    var educationalCourseRate: String?
}
// MARK: - EducationalCategoryCustomInfoData
struct EducationalCategoryCustomInfoData:Codable {
    var educationalCategoryToken: String?
    var fullCode: String?
    var educationalCategoryNameCurrent: String?
    var educationalCategoryFullNameCurrent: String?
    var educationalCategoryDescriptionCurrent: String?
    var storageFileToken: String?
    var educationalCategoryImageUrl: String?
    var educationalCategoryThumbnailImageUrl: String?
}

// MARK: - EducationalCourseSubscriptionPlan
struct EducationalCourseSubscriptionPlan :Codable{
    var subscriptionPlanNameAr: String?
    var subscriptionPlanNameEn: String?
    var subscriptionTypeToken: String?
    var subscriptionCountDays: Int?
    var subscriptionCountOpen: Int?
    var subscriptionPrice: Double?
}

// MARK: - StorageFileData
struct StorageFileDataa :Codable{
    var storageFileToken: String?
    var storageFileTitle: String?
    var serverStorageType: String?
    var moduleTypeToken: String?
    var thumbnailImageUrl: String?
    var watchViewUrl: String?
    var storageFileMediaTypeToken: String?
    var fileIsInProcess: Bool?
    var activationTypeToken: String?
    var helperData: HelperData?
    var storageFileStatistic: StorageFileStatistic?
    var errorData: ErrorData?
    var normalFileData: NormalFileData?
    var videoStreamData: VideoStreamData?
    var youtubeData: YoutubeData?
}

// MARK: - ErrorData
struct ErrorData :Codable{
    var isHaveError: Bool?
    var errorTextCurrent: String?
    var errorTextAr: String?
    var errorTextEn: String?
}

// MARK: - HelperData
struct HelperData :Codable{
    var ownedUserToken: String?
    var storageFolderToken: String?
    var creationDateTime: String?
    var creationDate: String?
    var creationTime: String?
}

// MARK: - NormalFileData
struct NormalFileData :Codable{
    var fileUrl: String?
    var durationifVideo: Int?
}

// MARK: - StorageFileStatistic
struct StorageFileStatisticc :Codable {
    var totalSizeSizeBytes: Int?
    var totalSizeSizeText: String?
    var numberTimesRequested: Int?
}

// MARK: - VideoStreamData
struct VideoStreamData :Codable{
    var videoGuid: String?
    var libraryId: Int?
    var durationVideo: Int?
}

// MARK: - YoutubeData
struct YoutubeDataa :Codable{
    var youtubeVideoId: String?
    var durationVideo: Int?
}

