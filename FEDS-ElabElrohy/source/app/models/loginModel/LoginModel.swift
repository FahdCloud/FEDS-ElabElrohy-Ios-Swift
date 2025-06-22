// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let logineModel = try LogineModel(json)

import Foundation

// MARK: - LogineModel
struct LogineModel : Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var apiAppData: APIAppData?
    var usersVersion: UsersVersion?
}

// MARK: - APIAppData
struct APIAppData : Codable {
    var userAuthorizeToken: String?
    var userLoginSessionToken: String?
    var projectTypeToken: Int?
    var userData: UserData?
    var userAppSettingData: UserAppSetting?
    var constantsListsData: ConstantsListsData?
}

// MARK: - ConstantsListsData
struct ConstantsListsData : Codable {
    var listDaysOfWeekData: [Lists]?
    var listActivationType: [Lists]?
    var listUserType: [Lists]?
    var listUserCompositeType: [Lists]?
    var listGender: [Lists]?
    var listReligionType: [Lists]?
    var listRelativeRelationType: [ListRelativeRelationType]?
    var listPlatFormType: [Lists]?
    var listMediaType: [Lists]?
    var listThemeType: [Lists]?
    var listLanguageType: [Lists]?
    var listDateFormatType: [Lists]?
    var listTimeFormatType: [Lists]?
    var listTimeZoneInfo: [Lists]?
    var listCodeInLoginType: [Lists]?
    var listAuthenticationLoginType: [Lists]?
    var listNumberOfPeriodType: [Lists]?
    var currency: Currency?
    var listPaymentMethod: [Lists]?
    var listNatureFinanceType: [Lists]?
    var listWalletTransactionType: [Lists]?
    var listAccountTransactionType: [Lists]?
    var listFullAccountTransactionType: [Lists]?
    var listRefundType: [Lists]?
    var listCancelType: [Lists]?
    var listDebtType: [Lists]?
    var listSchedulingStatusType: [Lists]?
    var listCommunicationType: [Lists]?
    var listReplyStatusType: [Lists]?
    var listInterestStateType: [Lists]?
    var listFullInterestStateType: [Lists]?
    var listServiceType: [Lists]?
    var listApprovalType: [Lists]?
    var listApplicationItemStateType: [Lists]?
    var listCanRelatedType: [Lists]?
    var listRelatedWithGroupType: [Lists]?
    var listQuestionType: [Lists]?
    var listClosedType: [Lists]?
    var listFinishType: [Lists]?
    var listAppointmentType: [Lists]?
    var listServiceProviderAmountType: [Lists]?
    var listServiceProviderPriceCalculationType: [Lists]?
    var listSubscriptionType: [Lists]?
    var listFullSubscriptionType: [Lists]?
    var listAttendanceType: [Lists]?
    var listModuleExamType: [Lists]?
    var listUserCanAttendaceStateType: [Lists]?
}

// MARK: - Currency
struct Currency : Codable {
    var isCurrencyNameFeminine: Bool?
    var itemNamePluralEn: String?
    var itemNameAr2: String?
    var itemNameAr310: String?
    var itemNameAr1199: String?
    var symbolCuurencyEn: String?
    var symbolCuurencyAr: String?
    var currencyPartNameEn: String?
    var currencyPartPluralNameEn: String?
    var currencyPartNameAr: String?
    var currencyPartNameAr2: String?
    var currencyPartNameAr310: String?
    var currencyPartNameAr1199: String?
    var isCurrencyPartNameFeminine: Bool?
    var partPrecision: Int?
    var itemToken: String?
    var itemFileUrl: String?
    var itemThumbnailImageUrl: String?
    var itemFullCode: String?
    var itemName: String?
    var itemNameAr: String?
    var itemNameEn: String?
}

// MARK: - List
struct Lists : Codable {
    var itemToken: String?
    var itemFileUrl: String?
    var itemThumbnailImageUrl: String?
    var itemFullCode: String?
    var itemName: String?
    var itemNameAr: String?
    var itemNameEn: String?
    var dayOfWeek: Int?
    var userCompositeTypeToken: String?
}



// MARK: - ListRelativeRelationType
struct ListRelativeRelationType : Codable {
    var conDuplicateRelationStatus: Bool?
    var secondSideRelativeRelationNameAr: String?
    var secondSideRelativeRelationNameEn: String?
    var itemToken: String?
    var itemFileUrl: String?
    var itemThumbnailImageUrl: String?
    var itemFullCode: String?
    var itemName: String?
    var itemNameAr: String?
    var itemNameEn: String?
}

// MARK: - UserAppSettingData
struct UserAppSettingData : Codable {
    var userAppSettingToken: String?
    var userToken: String?
    var userPlatFormToken: String?
    var userPlatFormNameCurrent: String?
    var themeToken: String?
    var themeNameCurrent: String?
    var timeZoneToken: String?
    var timeZoneNameCurrent: String?
    var dateFormatToken: String?
    var dateFormatNameCurrent: String?
    var timeFormatToken: String?
    var timeFormatNameCurrent: String?
    var languageToken: String?
    var languageNameCurrent: String?
    var startDayOfWeekToken: String?
    var startDayOfWeekNameCurrent: String?
    var startMonthOfYear: Int?
    var startMonthOfYearNameCurrent: String?
    var startDayOfMonth: Int?
    var backAfterAddStatus: Bool?
    var backAfterEditStatus: Bool?
    var receiveNotificationStatus: Bool?
    var customSettings: String?
}

// MARK: - UserData
struct UserData : Codable {
    var userToken: String?
    var userNameCurrent: String?
    var userNameAr: String?
    var userNameEn: String?
    var userPassword: String?
    var userPhoneCountryCode: String?
    var userPhoneCountryCodeName: String?
    var userPhone: String?
    var userPhoneWithCC: String?
    var userEmail: String?
    var userName: String?
    var userCompositeTypeToken: String?
    var userCompositeTypeCurrent: String?
    var userTypeToken: String?
    var userTypeNameCurrent: String?
    var userImageIsDefault: Bool?
    var userImageUrl: String?
    var userImageSizeBytes: Int?
    var userThumbnailImageUrl: String?
    var userThumbnailImageSizeBytes: Int?
    var userIsApproved: Bool?
    var userWalletBalance: Double?
    var userWalletBalanceText: String?
    var userWalletBalanceWithCurrency: String?
    var userCanBuyCourseFromWebview: Bool?
    var myChildren: [MyChild]?
//    var myParents: [Any?]?
    var userProfileData: UserProfileData?
    var establishmentRoleToken: String?
    var establishmentRoleData: EstablishmentRoleData?
    var dailyCode: Int?
    var fullCode: String?
    var activationTypeToken: String?
    var activationTypeNameCurrent: String?
    var timeZoneName: String?
    var createdByUserToken: String?
    var userCreatedData: UserCreatedData?
    var creationDateTime: String?
    var creationDateTimeCustomized: String?
    var creationDate: String?
    var creationTime: String?
    var lastUpdatedByUserToken: String?
    var userLastUpdatedData: UserCreatedData?
    var lastUpdateDateTime: String?
    var lastUpdateDateTimeCustomized: String?
    var lastUpdateDate: String?
    var lastUpdateTime: String?
}

// MARK: - EstablishmentRoleData
struct EstablishmentRoleData : Codable {
    var establishmentRoleToken: String?
    var dailyCode: Int?
    var fullCode: String?
    var establishmentRoleNameEn: String?
    var establishmentRoleNameAr: String?
    var establishmentRoleDescriptionCurrent: String?
    var establishmentRoleDescriptionAr: String?
    var establishmentRoleDescriptionEn: String?
    var establishmentRoleImageIsDefault: Bool?
    var establishmentRoleImageUrl: String?
    var establishmentRoleImageSizeBytes: Int?
    var establishmentRoleThumbnailImageUrl: String?
    var establishmentRoleThumbnailImageSizeBytes: Int?
    var userCompositeTypeToken: String?
    var userCompositeTypeCurrent: String?
    var authenticationLoginTypeToken: String?
    var authenticationLoginTypeNameCurrent: String?
    var codeInLoginTypeToken: String?
    var codeInLoginTypeNameCurrent: String?
    var establishmentRoleDefaultStatus: Bool?
    var activationTypeToken: String?
    var activationTypeNameCurrent: String?
    var modulePrivilegeData: [ModulePrivilegeDatum]?
    var creationDateTime: String?
    var creationDateTimeCustomized: String?
    var creationDate: String?
    var creationTime: String?
    var lastUpdateDateTime: String?
    var lastUpdateDateTimeCustomized: String?
    var lastUpdateDate: String?
    var lastUpdateTime: String?
    var establishmentRoleNameCurrent: String?
}

// MARK: - ModulePrivilegeDatum
struct ModulePrivilegeDatum : Codable {
    var moduleToken: String?
    var moduleNameCurrent: String?
    var moduleImagePath: String?
    var modulePrivilegeFuncations: [ModulePrivilegeFuncation]?
}

// MARK: - ModulePrivilegeFuncation
struct ModulePrivilegeFuncation : Codable {
    var moduleToken: String?
    var funcationToken: String?
    var funcationWithModuleToken: String?
    var funcationNameCurrent: String?
    var funcationImagePath: String?
    var isHavePrivlage: Bool?
    var appearanceStatus: Bool?
}

// MARK: - UserCreatedData
struct UserCreatedData : Codable {
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

// MARK: - UserProfileData
struct UserProfileData : Codable {
    var userGenderToken: String?
    var userGenderNameCurrent: String?
    var userReligionToken: String?
    var userReligionNameCurrent: String?
    var userNationalityToken: String?
    var userNationalityNameCurrent: String?
    var userNationalNumber: String?
    var userPhone2: String?
    var userPhoneCountryCode2: String?
    var userPhoneCountryCodeName2: String?
    var userPhone2WithCC: String?
    var userBirthdayDateTime: String?
    var userBirthdayDateTimeCustomized: String?
    var userBirthdayDate: String?
    var userBirthdayTime: String?
    var userAge: String?
    var userAddressCurrent: String?
    var userAddressAr: String?
    var userAddressEn: String?
    var userDescriptionCurrent: String?
    var userDescriptionAr: String?
    var userDescriptionEn: String?
}

// MARK: - UsersVersion
struct UsersVersion : Codable {
    var userVersionToken: String?
    var versionFeaturesCurrent: String?
    var versionFeaturesEn: String?
    var versionFeaturesAr: String?
    var versionPlatFormToken: String?
    var versionPlatFormNameCurrent: String?
    var versionPlatFormNameEn: String?
    var versionPlatFormNameAr: String?
    var versionNumber: String?
    var versionLinkDownload: String?
    var mustOpenThisVersionOrUpVersionStatus: Bool?
    var userVersionImageIsDefault: Bool?
    var userVersionImageUrl: String?
    var userVersionImageSizeBytes: Int?
    var userVersionThumbnailImageUrl: String?
    var userVersionThumbnailImageSizeBytes: Int?
    var dailyCode: Int?
    var fullCode: String?
    var activationTypeToken: String?
    var activationTypeNameCurrent: String?
    var timeZoneName: String?
    var createdByUserToken: String?
    var userCreatedData: UserCreatedData?
    var creationDateTime: String?
    var creationDateTimeCustomized: String?
    var creationDate: String?
    var creationTime: String?
    var lastUpdatedByUserToken: String?
    var userLastUpdatedData: UserCreatedData?
    var lastUpdateDateTime: String?
    var lastUpdateDateTimeCustomized: String?
    var lastUpdateDate: String?
    var lastUpdateTime: String?
}


// MARK: - MyChild
struct MyChild:Codable {
    var userToken: String?
    var userInfoData: UserInfoData?
    var relativeRelationToken: String?
    var relativeRelationNameCurrent: String?
}

// MARK: - UserInfoData
struct UserInfoData :Codable{
    var userToken: String?
    var userNameCurrent: String?
    var userDescriptionCurrent: String?
    var fullCode: String?
    var userTypeToken: String?
    var userTypeNameCurrent: String?
    var userImageIsDefault: Bool?
    var userImageUrl: String?
    var userImageSizeBytes: Int?
    var userThumbnailImageUrl: String?
    var userThumbnailImageSizeBytes: Int?
}
