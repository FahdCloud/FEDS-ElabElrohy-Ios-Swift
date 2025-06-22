//
//  GetAllMyCodeModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 26/11/2023.
//

import Foundation


// MARK: - GetAllMyCodeModel
struct GetAllMyCodeModel:Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var teacherCodeStatistics: TeacherCodeStatistics?
    var pagination: Pagination?
    var teacherCodesData: [TeacherCodesDatum]?
}

// MARK: - TeacherCodeStatistics
struct TeacherCodeStatistics :Codable{
    var totalCountSold: Int?
    var totalMoneySold: Int?
    var totalMoneySoldWithCurrency: String?
    var soldPercentage: Double?
    var soldPercentageText: String?
    var totalCountUnSold: Int?
    var totalMoneyUnSold: Int?
    var totalMoneyUnSoldWithCurrency: String?
    var unSoldPercentage: Double?
    var unSoldPercentageText: String?
    var totalCountRefound: Int?
    var totalMoneyRefound: Int?
    var totalMoneyRefoundWithCurrency: String?
    var refoundPercentage: Double?
    var refoundPercentageText: String?
    var totalCount: Int?
    var totalActiveCount: Int?
    var totalBlockedCount: Int?
    var totalActivePercentage: Double?
    var totalActivePercentageText: String?
    var totalBlockedPercentage: Double?
    var totalBlockedPercentageText: String?
}

// MARK: - TeacherCodesDatum
struct TeacherCodesDatum:Codable{
    var teacherCodeToken: String?
    var codeText: String?
    var codePrice: Double?
    var codePriceWithCurrency: String?
    var saleStatusTypeToken: String?
    var saleStatusTypeNameCurrent: String?
    var userServiceProviderInfoData: UserServiceProviderInfoData?
    var creationInfoData: CreationInfoData?
    var updateInfoData: UpdateInfoData?
    var teacherCodeSellingInfoData: TeacherCodeSellingInfoData?
    var teacherCodeRefundInfoData: TeacherCodeRefundInfoData?
}

// MARK: - CreationInfoData
struct CreationInfoData :Codable{
    var creationDateTime: String?
    var creationDateTimeCustomized: String?
    var creationDate: String?
    var creationTime: String?
    var userCreatInfoData: UserDataInfo?
}

// MARK: - TeacherCodeRefundInfoData
struct TeacherCodeRefundInfoData :Codable{
    var refundReasonCurrent: String?
    var refundDateTime: String?
    var refundDateTimeCustomized: String?
    var refundDate: String?
    var refundTime: String?
    var userRefundInfoData: UserDataInfo?
}

// MARK: - TeacherCodeSellingInfoData
struct TeacherCodeSellingInfoData :Codable{
    var sellingDateTime: String?
    var sellingDateTimeCustomized: String?
    var sellingDate: String?
    var sellingTime: String?
    var userStudentInfoData: UserDataInfo?
    var userSellerInfoData: UserDataInfo?
}

// MARK: - UpdateInfoData
struct UpdateInfoData :Codable{
    var lastUpdateDateTime: String?
    var lastUpdateDateTimeCustomized: String?
    var lastUpdateDate: String?
    var lastUpdateTime: String?
    var userUpdatedInfoData: UserDataInfo?
}
