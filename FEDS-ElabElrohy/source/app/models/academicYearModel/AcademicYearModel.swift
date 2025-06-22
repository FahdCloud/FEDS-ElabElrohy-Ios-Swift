//
//  AcademicYearModel.swift
//  FEDS-Dev-1.1
//
//  Created by Mrwan on 25/08/2024.
//

import Foundation


// MARK: - AcademicYearsModel
struct AcademicYearsModel :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var pagination: Pagination?
    var itemsData: [ItemsDatum]?
}

// MARK: - ItemsDatum
struct ItemsDatum :Codable{
    var itemToken: String?
    var itemFileUrl: String?
    var itemThumbnailImageUrl: String?
    var itemFullCode: String?
    var itemName: String?
    var itemNameAr: String?
    var itemNameEn: String?
    var otherData: OtherData?
}

// MARK: - OtherData
struct OtherData :Codable{
    var mustPayGroupSession: Bool?
    var seriousReservationPrice: Double?
}

