// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let financeModel = try? JSONDecoder().decode(FinanceModel.self, from: jsonData)

import Foundation

// MARK: - FinanceModel
struct FinanceModel : Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var userFinanceStatisticData: UserFinanceStatisticData?
}

// MARK: - UserFinanceStatisticData
struct UserFinanceStatisticData : Codable {
    var totalDebtsMoney: Double?
    var totalDebtsMoneyWithCurrency: String?
    var totalDebtsMoneyText: String?
    var totalPaidMoney: Double?
    var totalPaidMoneyWithCurrency: String?
    var totalPaidMoneyMoneyText: String?
    var totalRemainderMoney: Double?
    var totalRemainderMoneyWithCurrency: String?
    var totalRemainderMoneyMoneyText: String?
    var totalRefundMoney: Double?
    var totalRefundMoneyWithCurrency: String?
    var totalRefundMoneyMoneyText: String?
    var paidPercentage: Double?
    var paidPercentageText: String?
    var remainderPercentage: Double?
    var remainderPercentageText: String?
    var finishPercentage: Double?
    var finishPercentageText: String?
    var isHaveSchedulPercentage: Double?
    var isHaveSchedulPercentageText: String?
    var notHaveSchedulPercentage: Double?
    var notHaveSchedulPercentageText: String?
    var canceledDebtPercentage: Double?
    var canceledDebtPercentageText: String?
    var countDebts: Int?
    var countDebtsFinish: Int?
    var countDebtsNotFinish: Int?
    var countDebtsCanceled: Int?
    var countDebtsIsHaveSchedul: Int?
    var countDebtsNotHaveSchedul: Int?
    var lastUpdateStatisticsDateTime: String?
    var lastUpdateStatisticsDateTimeCustomized: String?
    var lastUpdateStatisticsDate: String?
    var lastUpdateStatisticsTime: String?
    var lastUpdateStatisticsFromText: String?
    var userToken: String?
    var userData: UserData?
}

