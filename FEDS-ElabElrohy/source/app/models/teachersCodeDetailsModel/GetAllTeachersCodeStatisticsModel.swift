//
//  GetAllTeachersCodeStatisticsModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 26/11/2023.
//

import Foundation

// MARK: - GetAllTeachersCodeStatisticsModel
struct GetAllTeachersCodeStatisticsModel :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var teacherCodeAvailablePricesStatistics: [TeacherCodeAvailablePricesStatistic]?
}

// MARK: - TeacherCodeAvailablePricesStatistic
struct TeacherCodeAvailablePricesStatistic:Codable {
    var price: Double?
    var totalCount: Int?
    var priceWithCurrency: String?
}
