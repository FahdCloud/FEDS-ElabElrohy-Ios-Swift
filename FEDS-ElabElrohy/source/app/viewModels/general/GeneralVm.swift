//
//  GeneralVm.swift
//  FEDS-Center-Dev-IOS
//
//  Created by Omar Pakr on 15/05/2024.
//

import Foundation
import UIKit

class GeneralVm: ObservableObject {
    @Published var constants = Constants()
    @Published var authToken = UserDefaultss().restoreString(key: "userAuth")
    @Published var userTypeToken  = UserDefaultss().restoreString(key: "userTypeToken")
    @Published var userToken = UserDefaultss().restoreString(key: "userToken")
    @Published var imageUrl = UserDefaultss().restoreString(key: "userImageUrl")
    @Published var phoneNumber = UserDefaultss().restoreString(key: "phoneNumber")
    @Published var userName = UserDefaultss().restoreString(key: "userNameCurrent")
    @Published var userLoginSessionToken = UserDefaultss().restoreString(key: "userLoginSessionToken")
    @Published var userProviderToken = UserDefaultss().restoreString(key: "userProviderToken")
    @Published var userProviderName =  UserDefaultss().restoreString(key: "userProviderName")
    @Published var categoryToken = UserDefaultss().restoreString(key: "categoryToken")
    @Published var courseToken = UserDefaultss().restoreString(key: "courseToken")
    @Published var userFullCode = UserDefaultss().restoreString(key: "userFullCode")
    @Published var studentExamToken = UserDefaultss().restoreString(key: "studentExamToken")

    @Published var deviceProcessor = UIDevice.current.getCPUName()
    @Published var deviceModelName = UIDevice.modelName
    @Published var deviceRam = ProcessInfo.processInfo.physicalMemory/1073741824
    @Published var deviceOS = ProcessInfo.processInfo.operatingSystemVersionString
    @Published var deviceOsVersion = UIDevice.current.systemVersion
    @Published var deviceName = UIDevice.current.name
    @Published var deviceDescrption = UIDevice.current.description
    @Published var systemVersion = UIDevice.current.systemVersion
    @Published var deviceUniqeId = UIDevice.current.identifierForVendor
    @Published var userPlatformTokn = "PFT-1"
    @Published var userFirebaseToken = UserDefaultss().restoreString(key: "fcmToken")
    @Published var havePermissionToView  = UserDefaultss().restoreBool(key: "havePermissionToView")
    @Published var appVersion =  Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String

    @Published var declarationAccepted : Bool = UserDefaultss().restoreBool(key: "declarationAccepted")
    @Published var isDark = UserDefaultss().restoreBool(key: "isDark")
    @Published var lang = Locale.current.language.languageCode!.identifier
    @Published var dissapearView : Bool = false

}

//@StateObject var genralVm : GeneralVm = GeneralVm()
