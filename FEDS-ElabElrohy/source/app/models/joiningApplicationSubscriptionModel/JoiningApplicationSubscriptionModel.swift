//
//  JoiningApplicationSubscriptionModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 30/10/2023.
//

import Foundation


// MARK: - JoiningApplicationSubscriptionModel
struct JoiningApplicationSubscriptionModel:Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var lastJoiningApplicationSubscription: LastJoiningApplicationSubscription?
    var pagination: Pagination?
    var joiningApplicationSubscriptionsData: [LastJoiningApplicationSubscription]?
}


// MARK: - LastJoiningApplicationSubscription
struct LastJoiningApplicationSubscription :Codable{
    var joiningApplicationSubscriptionToken: String?
    var priceListToken: String?
    var priceBeforeDiscount: Double?
    var priceBeforeDiscountWithCurency: String?
    var priceAfterDiscount: Double?
    var priceAfterDiscountWithCurency: String?
    var discountPercentageFromTotal: Double?
    var discountPercentageFromEnterprise: Double?
    var discountPercentageFromServiceProvider: Double?
    var joiningApplicationSubscriptionNotes: String?
    var subscriptionFromDateTime: String?
    var subscriptionFromDateTimeCustomized: String?
    var subscriptionFromDate: String?
    var subscriptionFromTime: String?
    var subscriptionToDateTime: String?
    var subscriptionToDateTimeCustomized: String?
    var subscriptionToDate: String?
    var subscriptionToTime: String?
    var subscriptionDurationCurrent: String?
    var subscriptionTypeToken: String?
    var subscriptionTypeNameCurrent: String?
    var subscriptionRequestSessionsNumber: Int?
    var subscriptionRemaningSessionsNumberCount: Int?
    var subscriptionFinishedSessionsNumberCount: Int?
    var refundTypeToken: String?
    var refundTypeNameCurrent: String?
    var educationalJoiningApplicationToken: String?
    var educationalJoiningApplicationInfoData: EducationalJoiningApplicationInfoData?
    var userStudentInfoData: UserStudentInfoData?
    var educationalCategoryInfoData: EducationalCategoryInfoData?
    var debtToken: String?
    var debtData: DebtData?
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

// MARK: - DebtData
struct DebtData:Codable {
    var debtToken: String?
    var debtOfModuleToken1: String?
    var debtOfModuleToken2: String?
    var debtOfModuleToken3: String?
    var debtTitleCurrent: String?
    var debtDescriptionCurrent: String?
    var debtTypeToken: String?
    var debtTypeNameCurrent: String?
    var userToken: String?
    var userInfoData: UserData?
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
    var userLastUpdatedData: UserData?
    var lastUpdateDateTime: String?
    var lastUpdateDateTimeCustomized: String?
    var lastUpdateDate: String?
    var lastUpdateTime: String?
}




// MARK: - EducationalJoiningApplicationInfoData
struct EducationalJoiningApplicationInfoData:Codable {
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

