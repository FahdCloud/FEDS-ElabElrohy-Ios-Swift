//
//  RigsterationModel.swift
//  FPLS-Dev
//
//  Created by Omar pakr on 04/10/2023.
//

import Foundation


// MARK: - RegistrationModule
struct RegistrationModule:Codable {
       var userClientFullCode: String?
       var userClientFullName: String?
       var userClientPhoneCountryCode: String?
       var userClientPhoneCountryCodeName: String?
       var userClientPhone: String?
       var userClientUserName: String?
       var isHaveParent: Bool?
       var isOldParent: Bool?
       var oldParentToken: String?
       var userParentFullName: String?
       var userParentPhoneCountryCode: String?
       var userParentPhoneCountryCodeName: String?
       var userParentPhone: String?
       var userParentUserName: String?
       var userParentEmail: String?
       var relativeRelationToken: String?
}

