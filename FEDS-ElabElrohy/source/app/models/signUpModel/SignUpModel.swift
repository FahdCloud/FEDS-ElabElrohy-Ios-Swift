//
//  RigsterationModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/10/2023.
//

import Foundation


// MARK: - RegistrationModule
struct SignUpModel:Codable {
    var languageToken: String?
    var userData: UserDataSignUp?
    var userDeviceData: UserDeviceDataSignUp?
}

// MARK: - UserData
struct UserDataSignUp:Codable {
    var languageToken: String?
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
    var userProfileData: UserProfileDataSignUp?
    var userContactInfoData: UserContactInfoData?
    

}

// MARK: - UserProfileData
struct UserProfileDataSignUp:Codable {
    var userGenderToken: String?
    var userReligionToken: String?
}


// MARK: - UserDeviceData
struct UserDeviceDataSignUp: Codable {
    var userPlatFormToken: String?
    var userFirebaseToken: String?
    var userVersionNumber: String?
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


// MARK: - UserContactInfoData
struct UserContactInfoData :Codable{
    var userSchool: String?
    var userGovernorateToken: String?
    var userGovernorateCityName: String?
    var userEducationSystemTypeToken: String?
    var userPlaceToken: String?
    var userAcademicYearToken: String?
    var userGuardianFatherPhoneCC: String?
    var userGuardianFatherPhone: String?
    var userGuardianMotherPhoneCC: String?
    var userGuardianMotherPhone: String?
}
