//
//  UserWalletTransactionModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 19/10/2023.
//

import Foundation


// MARK: - UserWalletTransactionModel
struct UserWalletTransactionModel:Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var userWalletTransactionStatistics: UserWalletTransactionStatistics?
    var pagination: Pagination?
    var userData: UserData?
    var userWalletTransactionsData: [UserWalletTransactionsDatum]?
}



// MARK: - UserWalletTransactionStatistics
struct UserWalletTransactionStatistics:Codable {
    var totalDepositCount: Int?
    var totalWithdrawCount: Int?
    var totalDepositMoney: Double?
    var totalDepositMoneyWithCurrency: String?
    var totalDepositMoneyText: String?
    var totalWithdrawMoney: Double?
    var totalWithdrawMoneyWithCurrency: String?
    var totalWithdrawMoneyText: String?
    var depositCountPercentage: Double?
    var depositCountPercentageText: String?
    var withdrawCountPercentage: Double?
    var withdrawCountPercentageText: String?
    var totalCount: Int?
    var totalActiveCount: Int?
    var totalBlockedCount: Int?
    var totalActivePercentage: Double?
    var totalActivePercentageText: String?
    var totalBlockedPercentage: Double?
    var totalBlockedPercentageText: String?
}

// MARK: - UserWalletTransactionsDatum
struct UserWalletTransactionsDatum :Codable{
    var userWalletTransactionToken: String?
    var userWalletTransactionValue: Double?
    var userWalletTransactionValueWithCurreny: String?
    var userWalletTransactionValueText: String?
    var userWalletTransactionTypeToken: String?
    var userWalletTransactionTypeNameCurrent: String?
    var userWalletTransactionMethodToken: String?
    var userWalletTransactionMethodNameCurrent: String?
    var userWalletTransactionNotes: String?
    var userToken: String?
    var userInfoData: UserCreatedDataClass?
    var accountToken: String?
    var accountInfoData: AccountInfoData?
    var dailyCode: Int?
    var fullCode: String?
    var activationTypeToken: String?
    var activationTypeNameCurrent: String?
    var timeZoneName: String?
    var createdByUserToken: String?
    var userCreatedData: UserCreatedDataClass?
    var creationDateTime: String?
    var creationDateTimeCustomized: String?
    var creationDate: String?
    var creationTime: String?
    var lastUpdatedByUserToken: String?
    var userLastUpdatedData: UserCreatedDataClass?
    var lastUpdateDateTime: String?
    var lastUpdateDateTimeCustomized: String?
    var lastUpdateDate: String?
    var lastUpdateTime: String?
}

// MARK: - AccountInfoData
struct AccountInfoData:Codable {
    var accountToken: String?
    var fullCode: String?
    var accountNameCurrent: String?
    var accountDescriptionCurrent: String?
    var accountBalance: Double?
    var accountBalanceWithCurrency: String?
    var absBalance: Double?
    var absBalanceWithCurrency: String?
    var debtBalance: Double?
    var debtBalanceWithCurrency: String?
    var creditBalance: Double?
    var creditBalanceWithCurrency: String?
    var accountImageIsDefault: Bool?
    var accountImageUrl: String?
    var accountImageSizeBytes: Int?
    var accountThumbnailImageUrl: String?
    var accountThumbnailImageSizeBytes: Int?
}

// MARK: - UserCreatedDataClass
struct UserCreatedDataClass :Codable{
    var userToken: String?
    var userNameCurrent: String?
    var fullCode: String?
    var userTypeToken: String?
    var userTypeNameCurrent: String?
    var userImageIsDefault: Bool?
    var userImageURL: String?
    var userImageSizeBytes: Int?
    var userThumbnailImageURL: String?
    var userThumbnailImageSizeBytes: Int?
}
