//
//  PlacesModel.swift
//  FEDS-Dev-1.1
//
//  Created by Mrwan on 25/08/2024.
//

import Foundation


// MARK: - PlacesModel
struct CenterPlacesModel :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var listSort: [ListSort]?
    var pagination: Pagination?
    var itemsData: [ItemsDatum]?
}
