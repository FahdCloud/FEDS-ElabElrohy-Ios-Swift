//
//  UsersModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 09/10/2023.
//

import Foundation


// MARK: - Users
struct Users :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var activationStatistics: ActivationStatistics?
    var pagination: Pagination?
    var usersData: [UsersDatum]?
}


// MARK: - UsersDatum
struct UsersDatum :Codable{
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
    var userProfileData: UserProfileData?
//    var userContactInfoData: NSNull?
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
//    var userLastUpdatedData: User?
    var lastUpdateDateTime: String?
    var lastUpdateDateTimeCustomized: String?
    var lastUpdateDate: String?
    var lastUpdateTime: String?
}
