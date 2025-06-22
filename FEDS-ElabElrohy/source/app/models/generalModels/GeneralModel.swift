// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let checkUserModel = try? JSONDecoder().decode(CheckUserModel.self, from: jsonData)

import Foundation

// MARK: - CheckUserModel
struct CheckUserModel:Codable {
    var status: Int?
    var msg: String?
    var executionTimeMilliseconds: Int?
    var apiAppData: APIAppData?
}

// MARK: - APIAppData
struct APIAppDataCheckUser:Codable {
    var userAuthorizeToken: String?
    var projectTypeToken: Int?
    var userData: UserData?
    var constantsListsData: ConstantsListsData?
}


struct GeneralModel : Codable {
    var status : Int?
    var msg : String?
}
