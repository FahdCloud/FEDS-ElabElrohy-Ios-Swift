//
//  EducationalCourseInfo.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 06/03/2024.
//

import Foundation


// MARK: - EducationalCourse
struct EducationalCourseInfo :Codable {
    var educationalCourseToken: String?
    var educationalCourseNameCurrent: String?
    var educationalCourseNameAr: String?
    var educationalCourseNameEn: String?
    var educationalCourseDescriptionCurrent: String?
    var educationalCourseDescriptionAr: String?
    var educationalCourseDescriptionEn: String?
    var countLevelsInEducationalCourse: Int?
    var educationalCoursePrice: Double?
    var educationalCoursePriceWithCurency: String?
    var educationalCoursePriceForLifeTime: Bool?
    var educationalCourseNaturePurchaseType: String?
    var ownedUserToken: String?
    var ownedUserInfoData: UserDataInfo?
    var educationalCategoryToken: String?
    var educationalCategoryInfoData: EducationalCategoryInfoData?
    var storageFileToken: String?
    var storageFileData: StorageFileData?
    var educationalCourseStudentSubscription: EducationalCourseStudentSubscription?
    var educationalCourseLevelsData: [EducationalCourseLevelsDatum]?
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
    var educationalCoursePrices_1: CoursePakagePrice?
    var educationalCoursePrices_2: CoursePakagePrice?
    var educationalCoursePrices_3: CoursePakagePrice?
    var educationalCoursePrices_4: CoursePakagePrice?
    var educationalCoursePrices_5: CoursePakagePrice?
    
}


// MARK: - EducationalCourseLevelsDatum
struct EducationalCourseLevelsDatum :Codable{
    var educationalCourseLevelToken: String?
    var educationalCourseLevelName: String?
    var educationalCourseLevelDetails: String?
    var educationalCourseLevelSortNumber: Int?
    var lockStatus: Bool?
    var educationalCourseLevelVideos: [EducationalCourseLevelVideo]?
//    var educationalCourseLevelQuestions: NSNull?
}

// MARK: - EducationalCourseLevelVideo
struct EducationalCourseLevelVideo: Codable {
    var levelVideoName: String?
    var levelVideoDetails: String?
    var storageFileToken: String?
    var storageFileData: StorageFileData?
    var lockStatus: Bool?
    var deductedFromBalance: Bool?
//    var levelVideoDuration: NSNull?
}

struct CoursePakagePrice: Codable {
    
    var priceisAvailableStatus: Bool?
    var price: Double?
    var priceWithCurency: String?
    var canOpenItemsTime: Int?
    
}

struct EducationalCourseStudentSubscription: Codable {
    
    var availableForLifeTime: Bool?
    var educationalCategoryEnrollmentStatus: Bool?
    var availableNumberTimesCanOpen: Int?
    
}
