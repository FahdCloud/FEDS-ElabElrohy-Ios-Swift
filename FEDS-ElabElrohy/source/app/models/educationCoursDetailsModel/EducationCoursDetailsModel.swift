//
//  EducationCoursDetailsModel.swift
//  FEDS-Dev-1.1
//
//  Created by Mrwan on 26/08/2024.
//

import Foundation


// MARK: - EducationalCoursDetailsModel
struct EducationalCoursDetailsModel:Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var educationalCourseInfoData: EducationalCourseInfoData?
}

// MARK: - EducationalCourseInfoData
struct EducationalCourseInfoData:Codable {
    var educationalCourseToken: String?
    var educationalCourseNameCurrent: String?
    var educationalCourseDescriptionCurrent: String?
    var educationalCourseNaturePurchaseType: String?
    var storageFileToken: String?
    var thumbnailImageForVideo: Bool?
    var canBuyFromUserBalance: Bool?
    var storageFileWatchViewUrl: String?
    var educationalCourseThumbnailImageUrl: String?
    var percentageForServiceProvider: Double?
    var percentageForEstablishment: Double?
    var educationalCoursePrice: Double?
    var educationalCoursePriceWithCurrency: String?
    var availableByDateTimeStatus: Bool?
    var availableDateTimeFromCustomized: String?
    var availableDateTimeToCustomized: String?
    var lastUpdateFromText: String?
    var userServiceProviderInfoData: UserServiceProviderInfoData?
    var educationalCategoryCustomInfoData: EducationalCategoryCustomInfoData?
    var educationalCourseStatsticInfoData: EducationalCourseStatsticInfoData?
    var educationalCourseStudentSubscriptionInfoData: EducationalCourseStudentSubscriptionInfoData?
    var educationalCourseChaptersInfoData: [EducationalCourseChaptersInfoDatum]?
    var educationalCourseSubscriptionPlans: [EducationalCourseSubscriptionPlan]?
}



// MARK: - EducationalCourseChaptersInfoDatum
struct EducationalCourseChaptersInfoDatum :Codable{
    var educationalCourseChapterToken: String?
    var educationalCourseChapterTitle: String?
    var educationalCourseLessonsInfoData: [EducationalCourseLessonsInfoDatum]?
}

// MARK: - EducationalCourseLessonsInfoDatum
struct EducationalCourseLessonsInfoDatum :Codable{
    var educationalCourseLessonToken: String?
    var educationalCourseChapterToken: String?
    var educationalCourseLessonTitle: String?
    var educationalCourseLessonNumber: Int?
    var educationalCourseLessonTypeToken: String?
    var canOpenFile: Bool?
    var canOpenMsg: String?
    var educationalCourseLessonFileInfo: EducationalCourseLessonFileInfo?
    var educationalCourseLessonExamInfo: EducationalCourseLessonExamInfo?
}

// MARK: - EducationalCourseLessonExamInfo
struct EducationalCourseLessonExamInfo :Codable{
    var examIsRequested: Bool?
    var studentExamToken: String?
    var examDeliveryStatusTypeToken: String?
    var systemFinalDegree: Double?
    var isSucsess: Bool?
    var totalQuestionDegree: Double?
    var systemPercentage: Double?
    var userCanReviewExamIfFailed: Bool?
    var userCanReviewExamIfSucsess: Bool?
    var userCanReExamIfAfterFailed: Bool?

}

// MARK: - EducationalCourseLessonFileInfo
struct EducationalCourseLessonFileInfo :Codable{
    var fileWatchViewUrl: String?
    var fileMediaTypeToken: String?
}



// MARK: - EducationalCourseStudentSubscriptionInfoData
struct EducationalCourseStudentSubscriptionInfoData :Codable{
    var educationalCourseStudentToken: String?
    var courseSubscriptionPlanNameCurrent: String?
    var courseSubscriptionTypeToken: String?
    var endSupscriptionDateTime: String?
    var endSupscriptionDateTimeCustomized: String?
    var endSupscriptionDate: String?
    var endSupscriptionTime: String?
    var endSupscriptionRelativeTimeText: String?
    var countRemainingOpenTime: Int?
    var courseProgressPercentage: Double?
    var lastLessonNumber: Int?
    var subscriptionIsValid: Bool?
    var subscriptionIsValidMsg: String?
}
