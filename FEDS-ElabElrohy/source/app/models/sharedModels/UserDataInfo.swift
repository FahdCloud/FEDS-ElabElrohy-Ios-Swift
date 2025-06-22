//
//  UserDataInfo.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 06/03/2024.
//

import Foundation

struct UserDataInfo :Codable{
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
