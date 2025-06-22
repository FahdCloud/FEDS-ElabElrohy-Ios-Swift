// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let getUserDetailsModel = try? JSONDecoder().decode(GetUserDetailsModel.self, from: jsonData)

import Foundation

// MARK: - GetUserDetailsModel
struct GetUserDetailsModel:Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var user: UserDetails?
}

// MARK: - User
struct UserDetails:Codable {
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
    var userImageURL: String?
    var userImageSizeBytes: Int?
    var userThumbnailImageURL: String?
    var userThumbnailImageSizeBytes: Int?
    var userIsApproved: Bool?
    var userWalletBalance: Double?
    var userWalletBalanceText: String?
    var userWalletBalanceWithCurrency: String?
    var userEducationalCategoryInfoInterests: [UserEducationalCategoryInfoInterest]?
    var userProfileData: UserProfileData?
    var userContactInfoData: UserContactData?
    var establishmentRoleToken: String?
    var establishmentRoleData: EstablishmentRoleData?
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


// MARK: - UserContactInfoData
struct UserContactData :Codable{
    var userContactInfoToken: String?
    var userWorkFieldTags: String?
    var userMapLink: String?
    var userWebSiteLink: String?
    var userTwitterLink: String?
    var userInstgramLink: String?
    var userFaceBookLink: String?
    var userYouTubeLink: String?
    var userFaxNumber: String?
    var userTaxNumber: String?
    var userPhoneCC1: String?
    var userPhone1: String?
    var userPhone1WithCC: String?
    var userPhone1IsHaveWhatsapp: Bool?
    var userPhoneCC2: String?
    var userPhone2: String?
    var userPhone2WithCC: String?
    var userPhone2IsHaveWhatsapp: Bool?
    var userPhoneCC3: String?
    var userPhone3: String?
    var userPhone3WithCC: String?
    var userPhone3IsHaveWhatsapp: Bool?
    var userEmail1: String?
    var userEmail2: String?
}


// MARK: - UserEducationalCategoryInfoInterest
struct UserEducationalCategoryInfoInterest:Codable {
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
    var mainRootToken: String?
    var rankingUnderParent: Int?
    var isHaveChildrenStatus: Bool?
}
