//
//  LogData.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 03/09/2023.
//


import Foundation

// MARK: - LogineModel
struct logData :Codable{
    var user: String?
    var userpassword: String?
    var languageToken: String?
    var userDeviceData: UserDeviceData?
}

// MARK: - UserDeviceData
struct UserDeviceData :Codable{
    var userVersionNumber: String?
    var userPlatFormToken: String?
    var userFirebaseToken: String?
    var userDeviceUniqueCode: String?
    var userDeviceId: String?
    var userDeviceName: String?
    var userDeviceCompany: String?
    var userDeviceOS: String?
    var userDeviceVersionOS: String?
    var userDeviceEMUI: String?
    var userDeviceRam: String?
    var userDeviceProcessor: String?
    var userDeviceDisplay: String?
    var userDeviceModel: String?
    var userDeviceSerial: String?
    var userDeviceDescription: String?
    var userDeviceNotes: String?
}


// MARK: - SignUpData
struct SignUpData :Codable {
    var languageToken: String?
    var userData: UserSignUpData?
    var userDeviceData: UserDeviceData?
}

// MARK: - UserData
struct UserSignUpData:Codable {
    var userTypeToken: String?
    var userNameAr: String?
    var userNameEn: String?
    var userNameUnd: String?
    var userPassword: String?
    var userPhoneCountryCode: String?
    var userPhoneCountryCodeName: String?
    var userPhone: String?
    var userEmail: String?
    var userName: String?
    var userProfileData: UserSignUpProfileData?
}

// MARK: - UserProfileData
struct UserSignUpProfileData :Codable{
    var userGenderToken: String?
    var userReligionToken: String?
}
