// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let educationGroupModel = try? JSONDecoder().decode(EducationGroupModel.self, from: jsonData)

import Foundation

// MARK: - EducationGroupModel
struct EducationGroupModel:Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var pagination: Pagination?
    var educationalGroupStudentsData: [EducationalGroupStudentsDatum]?
    var educationalGroupsData: [EducationalGroupsData]?
}

// MARK: - EducationalGroupStudentsDatum
struct EducationalGroupStudentsDatum :Codable{
    var educationalGroupStudentToken: String?
    var educationalGroupToken: String?
    var countTransferTimes: Int?
    var educationalGroupInfoData: EducationalGroupInfoDataa?
    var educationalCategoryInfoData: EducationalCategoryInfoDataa?
    var userStudentToken: String?
    var userStudentInfoDate: User?
    var educationalJoiningApplicationToken: String?
    var educationalJoiningApplicationInfoDate: EducationalJoiningApplicationInfoDate?
    var createdByUserToken: String?
    var userCreatedData: User?
    var creationDateTime: String?
    var creationDateTimeCustomized: String?
    var creationDate: String?
    var creationTime: String?
    var educationalGroupStudentWarningData: EducationalGroupStudentWarningData?
    var educationalGroupStudentFreezeData: EducationalGroupStudentFreezeData?
}

// MARK: - EducationalCategoryInfoData
struct EducationalCategoryInfoDataa :Codable{
    var educationalCategoryToken: String?
    var fullCode: String?
    var educationalCategoryNameCurrent: String?
    var educationalCategoryFullNameCurrent: String?
    var educationalCategoryDescriptionCurrent: String?
    var educationalCategoryImageIsDefault: Bool?
    var educationalCategoryImageUrl: String?
    var educationalCategoryImageSizeBytes: Int?
    var educationalCategoryThumbnailImageUrl: String?
    var educationalCategoryThumbnailImageSizeBytes: Int?
    var parentEducationalCategoryToken: String?
    var parentEducationalCategoryInfoData: EducationalCategoryInfoData?
    var mainRootToken: String?
    var rankingUnderParent: Int?
    var isHaveChildrenStatus: Bool?
}

// MARK: - EducationalGroupInfoData
struct EducationalGroupInfoDataa :Codable{
    var educationalGroupToken: String?
    var fullCode: String?
    var countStudents: Int?
    var educationalGroupNameCurrent: String?
    var educationalGroupDescriptionCurrent: String?
    var educationalGroupFinishTypeToken: String?
    var educationalGroupFinishTypeNameCurrent: String?
    var educationalGroupClosedStateTypeToken: String?
    var educationalGroupClosedStateTypeNameCurrent: String?
    var educationalGroupImageIsDefault: Bool?
    var educationalGroupImageUrl: String?
    var educationalGroupImageSizeBytes: Int?
    var educationalGroupThumbnailImageUrl: String?
    var educationalGroupThumbnailImageSizeBytes: Int?
    var sessionPriceFroClient: Double?
    var sessionPriceWithCurrencyFroClient: String?
    var durationPriceFroClient: Double?
    var durationPriceWithCurrencyFroClient: String?
    var userServiceProviderInfoData: UserServiceProviderInfoData?
    var educationalGroupStatisticsInfoData: EducationalGroupStatisticsInfoData?
}

// MARK: - EducationalGroupStatisticsInfoData
struct EducationalGroupStatisticsInfoData :Codable{
    var educationalGroupStatisticsInfoToken: String?
    var educationalGroupStartDateTime: String?
    var educationalGroupStartDateTimeCustomized: String?
    var educationalGroupStartDate: String?
    var educationalGroupStartTime: String?
    var educationalGroupEndDateTime: String?
    var educationalGroupEndDateTimeCustomized: String?
    var educationalGroupEndDate: String?
    var educationalGroupEndTime: String?
    var educationalGroupCountAppointments: Int?
    var educationalGroupCountExpiredAppointments: Int?
    var educationalGroupCountUpcomingAppointments: Int?
    var countStudents: Int?
}

// MARK: - PriceListData
struct PriceListData :Codable{
    var priceListToken: String?
    var priceListNameCurrent: String?
    var priceListNameAr: String?
    var priceListNameEn: String?
    var priceListDescriptionCurrent: String?
    var priceListDescriptionAr: String?
    var priceListDescriptionEn: String?
    var actualPackagePriceForClient: Double?
    var actualPackagePriceForClientWithCurrency: String?
    var priceListPackagePriceForClient: Double?
    var priceListPackagePriceForClientWithCurrency: String?
    var priceListPackagePriceInOfferForClient: Double?
    var priceListPackagePriceInOfferForClientWithCurrency: String?
    var priceListPackageInOfferStatus: Bool?
    var actualSessionPriceForClient: Double?
    var actualSessionPriceForClientWithCurrency: String?
    var priceListSessionPriceForClient: Double?
    var priceListSessionPriceForClientWithCurrency: String?
    var priceListSessionPriceInOfferForClient: Double?
    var priceListSessionPriceInOfferForClientWithCurrency: String?
    var priceListSessionInOfferStatus: Bool?
    var priceListImageIsDefault: Bool?
    var priceListImageURL: String?
    var priceListImageSizeBytes: Int?
    var priceListThumbnailImageURL: String?
    var priceListThumbnailImageSizeBytes: Int?
    var educationalCategoryToken: String?
    var educationalCategoryInfoData: EducationalCategoryInfoDataa?
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

// MARK: - User
struct User:Codable {
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

// MARK: - EducationalGroupStudentFreezeData
struct EducationalGroupStudentFreezeData:Codable {
    var isfreeze: Bool?
    var freezeStatusToken: String?
    var freezeStatusNameCurrent: String?
    var freezeStatusNameAr: String?
    var freezeStatusNameEn: String?
    var freezeReasonCurrent: String?
    var freezeReasonAr: String?
    var freezeReasonEn: String?
    var freezeUntilDateTime: String?
    var freezeUntilDateTimeCustomized: String?
    var freezeUntilDate: String?
    var freezeUntilTime: String?
}

// MARK: - EducationalGroupStudentWarningData
struct EducationalGroupStudentWarningData:Codable {
    var countWarningText: String?
    var countTureWarning: Int?
    var warningStatus1: Bool?
    var warningStatus2: Bool?
    var warningStatus3: Bool?
    var warningStatus4: Bool?
    var warningStatus5: Bool?
    var warningNotes1: String?
    var warningNotes2: String?
    var warningNotes3: String?
    var warningNotes4: String?
    var warningNotes5: String?
}

// MARK: - EducationalJoiningApplicationInfoDate
struct EducationalJoiningApplicationInfoDate :Codable{
    var fullCode: String?
    var educationalJoiningApplicationTitleCurrent: String?
    var educationalJoiningApplicationDescriptionCurrent: String?
    var canRelatedTypeToken: String?
    var canRelatedTypeNameCurrent: String?
    var approvalTypeToken: String?
    var approvalTypeNameCurrent: String?
    var educationalJoiningApplicationToken: String?
    var educationalCategoryToken: String?
    var userStudentToken: String?
    var userPreferredServiceProviderToken: String?
    var userPreferredPlaceToken: String?
    var knownMethodToken: String?
    var termToken: String?
}
struct EducationalGroupsData :Codable {
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
    var sessionPriceForClient: Double?
    var sessionPriceWithCurrencyFroClient: String?
    var amountValueOfSessionForServiceProvider: Double?
    var percentageOfSessionForServiceProvider: Double?
    var amountValueOfSessionForEstablishment: Double?
    var percentageOfSessionForEstablishment: Double?
    var durationPriceForClient: Double?
    var durationPriceWithCurrencyFroClient: String?
    var userStudentIsAlreadyEnrolment: Bool?
    var amountValueOfDurationForServiceProvider: Double?
    var percentageOfDurationForServiceProvider: Double?
    var amountValueOfDurationForEstablishment: Double?
    var percentageOfDurationForEstablishment: Double?
    var educationalGroupMaximumStudentsNumber: Int?
    var educationalGroupMinimumStudentsNumber: Int?
    var educationalGroupStatisticsInfoData: EducationalGroupStatisticsInfoData?
    var userServiceProviderToken: String?
    var userServiceProviderInfoData: UserServiceProviderInfoData?
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
    var userLastUpdatedData: UserData?
    var lastUpdateDateTime: String?
    var lastUpdateDateTimeCustomized: String?
    var lastUpdateDate: String?
    var lastUpdateTime: String?
}
