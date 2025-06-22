//
//  PlaceTreeModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 10/10/2023.
//

import Foundation


// MARK: - PlaceTree
struct PlaceTree :Codable{
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var cachToken: String?
    var activationStatistics: ActivationStatistics?
    var treesData: [TreesData]?
}



// MARK: - TreesDatum
struct TreesData :Codable{
    var key: String?
    var label: String?
    var data: DataClassPlace?
    var children: [TreesData]?
}

// MARK: - DataClass
struct DataClassPlace :Codable{
    var itemToken: String?
    var itemParentToken: String?
    var itemMainRootToken: String?
    var itemNameCurrent: String?
    var itemNameAr: String?
    var itemNameEn: String?
    var itemFullNameCurrent: String?
    var itemFullNameAr: String?
    var itemFullNameEn: String?
    var itemDescriptionCurrent: String?
    var itemDescriptionAr: String?
    var itemDescriptionEn: String?
    var itemLevel: Int?
    var fullPathUnderParent: String?
    var isHaveChildrenStatus: Bool?
    var itemImageIsDefault: Bool?
    var itemImageURL: String?
    var itemThumbnailImageURL: String?
    var dailyCode: Int?
    var fullCode: String?
    var userCreatedData: UserDataInfo?
    var creationDateTime: String?
    var creationDateTimeCustomized: String?
    var creationDate: String?
    var creationTime: String?
    var userLastUpdatedData: UserDataInfo?
    var lastUpdateDateTime: String?
    var lastUpdateDateTimeCustomized: String?
    var lastUpdateDate: String?
    var lastUpdateTime: String?
    var activationTypeToken: String?
    var activationTypeNameCurrent: String?
    var activationTypeNameAr: String?
    var activationTypeNameEn: String?
    var specificModuleData: SpecificModuleData?
}

// MARK: - SpecificModuleData
struct SpecificModuleData :Codable{
    var placeWorkFieldTags: String?
    var placeAddressAr: String?
    var placeAddressEn: String?
    var placeMapLink: String?
    var placeWebSiteLink: String?
    var placeTwitterLink: String?
    var placeInstgramLink: String?
    var placeFaceBookLink: String?
    var placeYouTubeLink: String?
    var placeFaxNumber: String?
    var placeTaxNumber: String?
    var placePhoneCC1: String?
    var placePhone1: String?
    var placePhone1WithCC: String?
    var placePhone1IsHaveWhatsapp: Bool?
    var placePhoneCC2: String?
    var placePhone2: String?
    var placePhone2WithCC: String?
    var placePhone2IsHaveWhatsapp: Bool?
    var placePhoneCC3: String?
    var placePhone3: String?
    var placePhone3WithCC: String?
    var placePhone3IsHaveWhatsapp: Bool?
    var placeEmail1: String?
    var placeEmail2: String?
}

